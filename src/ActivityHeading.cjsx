require("velocity-animate")
require("velocity-animate/velocity.ui")
React = require("react")
{ Component, PropTypes } = React
{ VelocityTransitionGroup } = require("velocity-react")
{ debounce, throttle } = require("lodash/function")
{ merge } = require("lodash/object")


class ActivityHeading extends Component

  constructor: (props)->
    super(props)
    @state = ({ status: no })

  componentWillMount: ->
    # bind methods per component instance
    @showStatus = throttle(@showStatus, @props.refreshRate)
    @hideStatus = debounce(@hideStatus, @props.refreshRate + 100)

  componentWillUnmount: ->
    @hideStatus.cancel()
    @showStatus.cancel()

  componentWillReceiveProps: (nextProps)->
    prevStatus = if @props.showActivityStatus then @props.activityStatus
    nextStatus = if nextProps.showActivityStatus then nextProps.activityStatus
    exitStatus = if nextProps.showCompleteStatus then nextProps.completeStatus
    if prevStatus and not nextStatus
      if exitStatus
        @showStatus(exitStatus)
      @hideStatus()
    if nextStatus
      @showStatus(nextStatus)

  hideStatus: =>
    @setState({ status: no })

  showStatus: (status)=>
    @setState({ status })

  render: ->
    enterAnimation =
      animation: "transition.slideDownIn"
      duration: @props.speed

    leaveAnimation = 
      animation: "transition.slideDownOut"
      duration: @props.speed * 0.75

    styles =
      wrapper:
        height: @props.height
        lineHeight: @props.height
        display: "block"
        position: "relative"
        overflow: "hidden"
        textAlign: "center"
      heading:
        position: "absolute"
        left: 0
        right: 0
        margin: 0
    styles = merge(styles, @props.styles)

    <VelocityTransitionGroup
      className={@props.className}
      enter={enterAnimation} 
      leave={leaveAnimation}
      style={styles.wrapper}>
       { 
        if @state.status
          # keys prevent re-animation on updates
          # TODO: use and expose h[1-6] tag prop?
          <span style={styles.heading} key="status">{@state.status}</span>
        else
          <span style={styles.heading} key="title">{@props.title}</span>
      }     
    </VelocityTransitionGroup>


ActivityHeading.displayName = "ActivityHeading"

ActivityHeading.propTypes =
  # Text to display when no status updates
  title: PropTypes.string.isRequired
  # Set true to animate status text in
  showActivityStatus: PropTypes.bool
  # Set true to update text just before enterText animates out
  showCompleteStatus: PropTypes.bool
  # Text that will animate in when shouldEnter is set true
  activityStatus: PropTypes.string
  # Text that will replace enterText just before it animates out
  completeStatus: PropTypes.string
  # Rate at which pushed props update state
  refreshRate: PropTypes.number.isRequired
  # Enter/leave animation speed
  speed: PropTypes.number.isRequired
  # Height of heading/title wrapper
  height: PropTypes.string.isRequired
  # Set custom styles to merge with defaults
  styles: PropTypes.shape
    wrapper: PropTypes.object
    heading: PropTypes.object

ActivityHeading.defaultProps = 
  activityStatus: "Loading..."
  completeStatus: "Done"
  showCompleteStatus: yes
  refreshRate: 1000
  speed: 300
  height: "1.5em"

module.exports = ActivityHeading