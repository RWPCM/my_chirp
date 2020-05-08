# # Change service name for each new project

# # test connection to postgres
# ./test_db_connection.sh chirp_db

# # Install Phoenix
# mix archive.install hex phx_new 1.5.1

# mix phx.new chirp --live

# cd chirp

# cd config
# sed -i 's/localhost/chirp_db/g' dev.exs test.exs
# cd ..
 

# mix phx.gen.live Timeline Post posts username body likes_count:integer reposts_count:integer

# # make requested changes to router.ex
# cd lib/chirp_web
# # sed -i '/\s\s\s\slive \"\/\", PageLive, :index/a \ \ \ \ live \"\/posts\", PostLive.Index, :index' router.ex

# # etc pour obtenir :
# #   scope "/", ChirpWeb do
# #     pipe_through :browser
# 
# #     live "/", PageLive, :index
# 
# #     live "/posts", PostLive.Index, :index
# #     live "/posts/new", PostLive.Index, :new
# #     live "/posts/:id/edit", PostLive.Index, :edit
# 
# #     live "/posts/:id", PostLive.Show, :show
# #     live "/posts/:id/show/edit", PostLive.Show, :edit
# #   end

# cd ../..

# mix ecto.migrate

# # Launch server
# mix phx.server

# # Application specific

# # make change form_component.html.leex to

# #   ...
#   phx_submit: "save" %>

# #   <%= textarea f, :body %>
# #   <%= error_tag f, :body %>

# #   <%= submit "Save", phx_disable_with: "Saving..." %>
# #   ...

# # make change to lib/chirp/timeline/post.ex

#   schema "posts" do
#     field :body, :string
#     field :likes_count, :integer, default: 0
#     field :reposts_count, :integer, default: 0
#     field :username, :string, default: "Regis"

# # make change to lib/chirp_web/live/post_live/post_component.ex


# # In particular remove the following in index.html.eex

# <table>
#   <thead>
#     <tr>
#       <th>Username</th>
#       <th>Body</th>
#       <th>Likes count</th>
#       <th>Reposts count</th>

#       <th></th>
#     </tr>
#   </thead>
#   <tbody id="posts">
#     <%= for post <- @posts do %>
#       <tr id="post-<%= post.id %>">
#         <td><%= post.username %></td>
#         <td><%= post.body %></td>
#         <td><%= post.likes_count %></td>
#         <td><%= post.reposts_count %></td>

#         <td>
#           <span><%= live_redirect "Show", to: Routes.post_show_path(@socket, :show, post) %></span>
#           <span><%= live_patch "Edit", to: Routes.post_index_path(@socket, :edit, post) %></span>
#           <span><%= link "Delete", to: "#", phx_click: "delete", phx_value_id: post.id, data: [confirm: "Are you sure?"] %></span>
#         </td>
#       </tr>
#     <% end %>
#   </tbody>
# </table>

# # and replace with:

# <div id="posts" phx-update="prepend">
#   <%= for post <- @posts do %>
#     <%= live_component @socket, ChirpWeb.PostLive.PostComponent, id: post.id, post: post %>
#   <% end %>
# </div>

# # in form_component.html.leex remove:

#   <%= label f, :username %>
#   <%= text_input f, :username %>
#   <%= error_tag f, :username %>

#   <%= label f, :body %>
#   <%= text_input f, :body %>
#   <%= error_tag f, :body %>

#   <%= label f, :likes_count %>
#   <%= number_input f, :likes_count %>
#   <%= error_tag f, :likes_count %>

#   <%= label f, :reposts_count %>
#   <%= number_input f, :reposts_count %>
#   <%= error_tag f, :reposts_count %>

# # and replace with:

#   <%= textarea f, :body %>
#   <%= error_tag f, :body %>