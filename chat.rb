require "openai"
require "dotenv/load"

# Create new objects
client = OpenAI::Client.new(access_token: ENV.fetch("OPENAI_API_KEY"))
user_response = String.new

# Start chat
puts "Hello! How can I help you today?"
puts "-" * 50

# Loop until user says "end"
user_response = gets.chomp

# Establishing Starting Message List
message_list = [
  {
    "role" => "system",
    "content" => "You are a helpful assistant."
  },
  {
    "role" => "user",
    "content" => user_response
  }
]

while user_response.downcase != "bye"

  # Call the API to get the next message from GPT
  api_response = client.chat(
    parameters: {
      model: "gpt-3.5-turbo",
      messages: message_list
    }
  )

  next_message = api_response.fetch("choices").at(0).fetch("message")

  message_list.push(next_message)

  puts next_message.fetch("content")

  puts "-" * 50

  user_response = gets.chomp

  message_list.push({"role" => "user","content" => user_response})

end
