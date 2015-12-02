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
  sql = "SELECT * FROM tasks WHERE id = #{params[:id]}"
  @individual_task = run_sql(sql)
  erb :show
end

get '/tasks/:id/edit' do
  # retrieve and edit a task from DB where id = :id
  sql = "SELECT * FROM tasks WHERE id = #{params[:id]}"
  @task = run_sql(sql).first
  erb :edit
end

post '/tasks/:id' do
  # persists the edited task to the DB where id = :id
  new_name = params[:name]
  new_details = params[:details]
  edit_id = params[:id]
  sql = "UPDATE tasks SET name = '#{new_name}', details = '#{new_details}' WHERE id = #{edit_id}"

  run_sql(sql)
  redirect to('/tasks')
end

post '/tasks/:id/delete' do
  # deleted task from DB where id = :id
  sql = "DELETE FROM tasks WHERE id = #{params[:id]}"
  run_sql(sql)
  redirect to('/tasks')
end

def run_sql(sql)
  connect = PG.connect(dbname: 'todo', host: 'localhost')

  result = connect.exec(sql)

  connect.close

  result
end

















