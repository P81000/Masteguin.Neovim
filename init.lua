require('masteguin')

function print_banner()
    local width = vim.fn.winwidth(0)
    local border = string.rep('=', width)
   
    vim.api.nvim_echo({{border, 'Type'}, {''}}, true, {})
end

local banner = [[
                                                              _       
                    _                                        (_)      
 ____  _____  ___ _| |_ _____  ____    ____  _____  ___ _   _ _ ____  
|    \(____ |/___|_   _) ___ |/ ___)  |  _ \| ___ |/ _ \ | | | |    \ 
| | | / ___ |___ | | |_| ____| |      | | | | ____| |_| \ V /| | | | |
|_|_|_\_____(___/   \__)_____)_|      |_| |_|_____)\___/ \_/ |_|_|_|_|
                                                                      
]]

print_banner()
vim.api.nvim_echo({{banner, 'Type'}, {''}}, true, {})
print_banner()
vim.api.nvim_echo({{'Neovim - Welcome back Pedro', 'Type'}, {''}}, true, {})
print('                           ')
