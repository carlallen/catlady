task :build, :distribution do |t, args|
  Catlady::Builder.build(args[:distribution])
end