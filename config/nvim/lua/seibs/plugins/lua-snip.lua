require("luasnip.loaders.from_vscode").lazy_load()

require("luasnip").config.set_config({
    delete_check_events = "TextChanged",
    region_check_events = "InsertEnter",
})
