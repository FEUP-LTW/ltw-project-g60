<?php

function set_csrf(){
  if (!isset($_SESSION['csrf'])){
    $_SESSION['csrf'] = generate_random_token();
  }
}

function generate_random_token() {
  return bin2hex(openssl_random_pseudo_bytes(32));
}