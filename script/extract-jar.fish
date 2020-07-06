#!/usr/bin/env fish

function do_func
  set -l _project docker-gradle-spring-boot-template

  argparse -n do_func 'h/help' 'j/jar=' -- $argv
  or return 1

  if set -lq _flag_help
    echo "extract-jar.fish -j/--jar <JAR_FILENAME>"
    return
  end

  set -lq _flag_jar
  or set -l _flag_jar demo.jar
  
  cd (pwd |awk -F "/$_project" '{print $1}')/$_project/build/libs/ && jar xvf $_flag_jar && cd -
end

do_func $argv
