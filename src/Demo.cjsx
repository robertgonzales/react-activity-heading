React = require("react")
ActivityHeading = require("./ActivityHeading")


class Demo extends React.Component

  constructor: (props)->
    super(props)
    # Simulate store
    @state =
      is_saving: no
      save_success: no

  showStatus: (e)=>
    e.preventDefault()
    return if @state.is_saving
    @setState
      is_saving: yes
    # Simulate async
    setTimeout =>
      @setState
        is_saving: no
        save_success: yes
    , 100

  render: ->
    <div style={styles.container}>
      <div style={styles.header}>
        <ActivityHeading
          title="My Heading"
          activityStatus="Saving..."
          completeStatus="Saved"
          showActivityStatus={@state.is_saving}
          showCompleteStatus={yes}
          height="40px"
        />
      </div>
      <div style={styles.body}>
        <button 
          style={styles.button} 
          onClick={@showStatus}>
          Push status
        </button>
      </div>
    </div>


styles =
  container:
    maxWidth: "600px"
    margin: "100px auto"
    backgroundColor: "#fff"
    border: "1px solid #ddd"
    borderRadius: "10px"
  header:
    width: "100%"
    borderBottom: "1px solid #eee"
  body:
    display: "flex"
    justifyContent: "flex-end"
    alignItems: "flex-end"
    height: "200px"
    padding: "10px"
  button:
    padding: "5px 10px"
    backgroundColor: "#ddd"
    outline: "none"
    border: "none"
    borderRadius: "15px"
    fontSize: "15px"

module.exports = Demo