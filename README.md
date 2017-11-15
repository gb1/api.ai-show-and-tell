
## Installation

This is some code which is used in the show and tell session "Open the pod bay doors HAL 📣 - talking to SAP with a conversational bot 🚵"

To start the server:

Edit the URL for your OData service in `sap_client.ex` and modify the fields in `router.ex` to match the names of your OData service.

Run the following:
* `mix deps.get`
* `mix -S iex`
* In the iex repl run `Bookings.Router.start_link()`

[Youtube link to Show and Tell session](
https://www.youtube.com/watch?v=vxfG-SVEnPs&index=9&list=PLfctWmgNyOIedb1RLMXyD87Q5Ch_Soub-&t=608s)
