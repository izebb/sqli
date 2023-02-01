(lang dune 3.6)

(name sqli)

(generate_opam_files true)

(source
 (github izebb/sqli))

(authors "Gabriel Izebhigie")

(package
 (name sqli)
 (synopsis "Sqlite implementation")
 (description "An SQLite implementation experimenet of how database works")
 (depends ocaml dune)
 (tags
  (topics ocaml sql)))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/dune-files.html#dune-project
