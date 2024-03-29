get '/' do
  @posts = Post.all
  erb :'posts/index'
end

get '/posts/:id/show' do
  @post = Post.find(params[:id])
  @comment = Comment.new
  erb :'posts/show'
end

get '/posts/new' do
  @post = Post.new
  erb :'posts/_form_post'
end

post '/posts/create' do
  @post = current_user.posts.create(params[:post])

  if @post.valid?
    redirect "/"
  else
    erb :'posts/_form_post'
  end
end

post '/posts/:id/comments/create' do 
  @post = Post.find(params[:id])
  @post.comments.create(params[:comment]).update_attributes(user_id: current_user.id)
  @comment = Comment.new

  erb :'posts/show'
end
