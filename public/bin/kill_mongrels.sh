
f_list() {
  ps aux | grep mongrel | grep ruby
}

f_list
echo "  Killing them now...."
f_list | cut -c11-14 | xargs kill -9
echo "  Done"
f_list
