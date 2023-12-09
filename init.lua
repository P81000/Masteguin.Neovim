require('masteguin')

function print_banner()
    local width = vim.fn.winwidth(0)
    local border = string.rep('=', width)
   
    vim.api.nvim_echo({{border, 'Type'}, {''}}, true, {})
end

local banner = [[
  ______                                ______           _    _ _       
 |  ___ \            _                 |  ___ \         | |  | (_)      
 | | _ | | ____  ___| |_  ____  ____   | |   | | ____ __| |  | |_ ____  
 | || || |/ _  |/___)  _)/ _  )/ ___)  | |   | |/ _  ) _ \ \/ /| |    \ 
 | || || ( ( | |___ | |_( (/ /| |      | |   | ( (/ / |_| \  / | | | | |
 |_||_||_|\_||_(___/ \___)____)_|      |_|   |_|\____)___/ \/  |_|_|_|_|
]]

print_banner()
vim.api.nvim_echo({{banner, 'Type'}, {''}}, true, {})
print_banner()
vim.api.nvim_echo({{'Neovim - Welcome back Pedro', 'Type'}, {''}}, true, {})
print('                           ')
