lib LibC
  fun exit(code : Int32)
end

fun bla = crystal_do_something
  LibC.exit(42)
end
