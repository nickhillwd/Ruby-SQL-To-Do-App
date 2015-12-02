require 'sinatra'
require 'sinatra/contrib/all' if development?
require 'pry-byebug'
require 'pg'

get '/tasks' do
  #get all tasks from DB
  sql = "SELECT * FROM tasks"
  @tasks = run_sql(sql)
  erb :index
end

get '/tasks/new' do
  #render a from
  erb :new
end

post '/tasks' do
  # persists new task to DB
  name = params[:name]
  details = params[:details]
  sql = "INSERT INTO tasks (name, details) VALUES ('#{name}', '#{details}')"
  run_sql(sql)
  redirect to('/tasks')
end

get '/tasks/:id' do
  # get individual task from DB where id = :id
end

get '/tasks/:id/edit' do
  # retrieve and edit a task from DB where id = :id
end

post '/tasks/:id' do
  # persists the edited task to the DB where id = :id
end

post '/tasks/:id/delete' do
  # deleted task from DB where id = :id
end

def run_sql(sql)
  connect = PG.connect(dbname: 'todo', host: 'localhost')

  result = connect.exec(sql)

  connect.close

  result
end

















