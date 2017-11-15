defmodule Bookings.Router do
  use Plug.Router
  alias Bookings.{Reply, SapClient}

  plug Plug.Parsers, parsers: [:json],
                   pass:  ["text/*"],
                   json_decoder: Poison
  plug :match
  plug :dispatch

  def start_link do
    Plug.Adapters.Cowboy.http(Bookings.Router, [])
  end

  get "/" do
    conn
    |> send_resp(200, "Yo")
  end

  post "/webhook" do
    ## Log out the JSON
    IO.puts inspect conn.body_params, pretty: true, limit: 30000

    ## Pattern match out the entity values from the JSON
    %{"duration" => %{"amount" => amount, "unit" => unit},
      "email" => email,
      "no_of_consultants" => no_of_consultants,
      "skill" => skill
      } = conn.body_params
    |> Map.get("result")
    |> Map.get("contexts")
    |> List.first
    |> Map.get("parameters")

    ## Create an OData JSON reply and send it to SAP in a new process
    spawn fn ->
      SapClient.create_booking(
      %{"Skill": skill,
      "NumberOfConsultants": no_of_consultants,
      "LengthOfProject": Integer.to_string(amount) <> unit,
      "ContactEmail": email}
      )
    end

    ## Send an OK back to API.AI along with a confirmation message "ok done!"
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Poison.encode!(%Reply{ speech: "ok done!", displayText: "ok done!" }))
  end

end
