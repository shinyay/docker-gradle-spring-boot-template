#!/usr/bin/env fish

function do_func
  set -l _project docker-gradle-spring-boot-template

  argparse -n do_func 'h/help' 'j/jar=' 'r/release=' -- $argv
  or return 1

  if set -lq _flag_help
    echo "jdeps.fish -j/--jar <JAR_FILENAME> -r/--release <MULTI_RELEASE_VERSION>"
    return
  end

  set -lq _flag_jar
  or set -l _flag_jar demo.jar
  set -lq _flag_release
  or set -l _flag_release base 

  cd (pwd |awk -F "/$_project" '{print $1}')/$_project/build/libs/ && \
  jdeps --class-path "BOOT-INF/lib/*" \
    --multi-release $_flag_release  \
    --ignore-missing-deps \
    -recursive \
    --print-module-deps \
    $_flag_jar && \
  cd -
end

do_func $argv
