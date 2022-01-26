# TimezoneConverter

Create a web application that converts entered time between chosen time zones. The goal of
the task is to demonstrate the ability to work with Phoenix and Ecto.

## Requirements

 - The application asks to enter the needed time in the input field.
 - By default it is pre-filled with current time which is updating live.
 - Users can also enter custom time, then the time doesn't update anymore.
 - Below the input field there is a link to use "current time".
 - Below the user can also add cities. In this example the user has added Hamburg and Beijing.
 - There is a button to delete cities from the list.
 - To add a new city, the user can enter a city name in the field, which acts as auto-complete for supported cities in the application.
 - The list of cities and their time zones comes from a database table.
 - In the list of cities, the time should also auto-update if the user is converting current time.

## Technical requirements
  1. Write the application with Phoenix and Ecto. For frontend you can use anything you like (LiveView, Channels, any JS framework). You are free to use any dependencies needed.
  2. Apply CSS styling to make it look modern and user friendly.
  3. Write tests.
  4. Send us a GitHub repository with the end result and instructions.