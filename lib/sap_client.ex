defmodule Bookings.SapClient do

  @url "http://ubuntu:8000/sap/opu/odata/sap/ZBOOKINGS_SRV/BookingSet"
  # @booking %{"Skill": "erlang", "NumberOfConsultants": "1", "LengthOfProject": "3", "ContactEmail": "g@g.ie"}

  def create_booking(booking) do
    HTTPoison.start()
    HTTPoison.post(
      @url,
       Poison.encode!(booking),
      [{"Content-Type", "application/json"}, {"X-Requested-With", "X"}] )
  end

end
