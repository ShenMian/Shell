#!/bin/bash

import io system

# 灵感来源: http://lab.madscience.nl/oo.sh.txt
# 注意: 调用成员函数时, 以该类的其他成员为名的函数和变量和会被重定义
#       this 仅用于表示实例的 id, 成员函数可以直接通过名称调用

# 声明类
function class {
  [ -z "$2" ] || exit 1

  local name="$1"
  _CUR_CLASS_NAME="$name"
  _CUR_CLASS_SIG="_CLASS_${_CUR_CLASS_NAME}"
  eval ${_CUR_CLASS_SIG}_PUB_FUNCS=""
  eval ${_CUR_CLASS_SIG}_PRI_FUNCS=""
  eval ${_CUR_CLASS_SIG}_VARS=""
}

_CUR_ACCESS="PUB"

# 声明当前访问控制符为 public
function pub {
  _CUR_ACCESS="PUB"
}

# 声明当前访问控制符为 private
function pri {
  _CUR_ACCESS="PRI"
}

# 声明类的成员函数
function fn {
  local name="$1"
  local var_name="${_CUR_CLASS_SIG}_${_CUR_ACCESS}_FUNCS"
  eval "$var_name=\"\${$var_name}$1 \""
}

# 声明类的成员变量
function var {
  local name="$1"
  local var_name="${_CUR_CLASS_SIG}_VARS"
  eval "$var_name=\"\${$var_name}$1 \""
}

function load_funcs {
  local class_name
  eval "class_name=\"\${_INSTANCE_${this}_TYPE}\""
  local class_sig="_CLASS_${class_name}"

  local funcs
  eval "funcs=\"\${${class_sig}_PUB_FUNCS} \${${class_sig}_PRI_FUNCS}\""
  for func in $funcs; do
    eval "function ${func} {                 \
      ${class_name}::${func} \"\$*\"; \
      return \$?
    }"
  done
}

function unload_funcs {
  local class_name
  eval "class_name=\"\${_INSTANCE_${this}_TYPE}\""
  local class_sig="_CLASS_${class_name}"

  local funcs
  eval "funcs=\"\${${class_sig}_PUB_FUNCS} \${${class_sig}_PRI_FUNCS}\""
  for func in $funcs; do
    unset -f func
  done
}

function load_vars {
  local class_name
  eval "class_name=\"\${_INSTANCE_${this}_TYPE}\""
  local class_sig="_CLASS_${class_name}"

  local vars
  eval "vars=\"\${${class_sig}_VARS}\""
  for var in $vars; do
    eval "${var}=\"\${_INSTANCE_${this}_${var}}\""
  done
}

function unload_vars {
  local class_name
  eval "class_name=\"\${_INSTANCE_${this}_TYPE}\""
  local class_sig="_CLASS_${class_name}"

  local vars
  eval "vars=\"\${${class_sig}_VARS}\""
  for var in $vars; do
    eval "_INSTANCE_${this}_${var}=\"\$${var}\""
  done
}

# 创建类的实例
function new {
  local class_name="$1"
  local var_name="$2"
  shift
  shift

  eval "[ -n \"\${_INSTANCE_${var_name}_ID+x}\" ]" && {
    error "Can not create two instances have same name at same time"
    exit 1
  }

  local id=$(uuidgen | tr A-F a-f | sed -e "s/-//g")
  eval _INSTANCE_${id}_TYPE="$class_name"
  eval _INSTANCE_${var_name}_ID="$id"

  # 创建函数钩子
  local class_sig="_CLASS_${class_name}"
  local funcs
  eval "funcs=\"\$${class_sig}_PUB_FUNCS\""
  for func in $funcs; do
    [[ $(type -t ${class_name}::${func}) == function ]] || warn "oo: function '${class_name}::${func}' does not exist"
    eval "function ${var_name}.${func} { \
      local store_this=\"\$this\";       \
      load_vars;                         \
      this=$id;                          \
      load_funcs;                        \
      ${class_name}::${func} \"\$*\";    \
      local ret=\$?;                     \
      unload_funcs;                      \
      unload_vars;                       \
      this=\"\$store_this\";             \
      return \$ret
    }"
  done

  # 调用构造函数(如果存在)
  [[ $(type -t ${var_name}.${class_name}) == function ]] && eval "${var_name}.${class_name} \"\$*\" || true"
}

function delete {
  local var_name="$1"
  shift
  local id
  eval "id=\"\${_INSTANCE_${var_name}_ID}\""
  local class_name=
  eval "class_name=\"\${_INSTANCE_${id}_TYPE}\""
  
  # 调用析构函数(如果存在)
  [[ $(type -t ${var_name}.-${class_name}) == function ]] && eval "${var_name}.-${class_name} \"\$*\" || true"

  # 删除函数钩子
  local class_sig="_CLASS_${class_name}"
  local funcs
  eval "funcs=\"\$${class_sig}_PUB_FUNCS\""
  for func in $funcs; do
    unset -f ${var_name}.${func}
  done
  unset -f ${var_name}.${class_name}
  unset -f ${var_name}.-${class_name}

  # 删除成员变量
  local vars
  eval "vars=\"\${${class_sig}_VARS}\""
  for var in $vars; do
    unset "_INSTANCE_${id}_${var}"
  done

  unset _INSTANCE_${var_name}_ID
  unset _INSTANCE_${id}_TYPE
}

require uuidgen
