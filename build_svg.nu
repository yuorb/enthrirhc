$env.config.table.show_empty = false

ls -s assets/icons
    | get name
    | par-each { |filename| dart run vector_graphics_compiler -i $"assets/icons/($filename)" -o $"assets/icons_compiled/($filename).vec" }