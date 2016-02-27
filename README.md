react-activity-heading
======================
`<ActivityHeading />` lets you push activity state to a heading area, temporary replacing the text with a status message. Under the hood it throttles the rate at which new props are converted to state so that fast update changes are displayed and the animations always look good. 

You also have the ability to update the status message just before it animates out. This is useful for displaying success/error messages.

![activity-heading-gif](https://cloud.githubusercontent.com/assets/7729885/13375753/0f30a63e-dd76-11e5-9551-9fdc44cf06a6.gif)

## Usage

Example usage of `<ActivityHeading />`:

```jsx
<ActivityHeading 
  title="My Heading"
  showActivityStatus={this.state.is_saving}
  activityStatus="Saving..."
  showCompleteStatus={this.state.save_success}
  completeStatus="Saved"
/>
```


## Props

#### `title` str
Text to display when there is no activity status.

#### `showActivityStatus` bool
Set true to animate status text in.

#### `activityStatus` str
Text that will animate in when `showActivityStatus` is set true

#### `showCompleteStatus` bool
Set true to update text just before `activityStatus` animates out

#### `completeStatus` str
Text that will replace `activityStatus` just before it animates out

#### `refreshRate` num
Rate (in milliseconds) at which pushed props update state. Default `1000`.

#### `speed` num
Enter/leave animation speed (in milliseconds). Default `300`.

#### `height` str
Set the height of wrapper. Necessary because of absolute positioned content.

#### `styles` obj
Apply custom styles to `wrapper` and `heading`. Merged with default styles.
