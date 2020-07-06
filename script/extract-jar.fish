#!/usr/bin/env fish

function do_func
  argparse -n do_func 'h/help' 'j/jar=' -- $argv
  or return 1

  if set -lq _flag_help
    echo "extract-jar.fish -j/--jar <JAR_FILENAME>"
    return
  end

  set -lq _flag_jar
  or set -l _flag_jar demo.jar
  
  cd (pwd |awk -F '/docker-gradle-spring-boot-template' '{print $1}')/docker-gradle-spring-boot-template/build/libs/ && jar xvf $_flag_jar && cd -
end

do_func $argv
