json.array!(@tickets) do |ticket|
  json.extract! ticket, :id, :customer_email, :customer_name, :created_by, :assigned_to, :area
  json.url ticket_url(ticket, format: :json)
end
