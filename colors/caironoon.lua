for k in pairs(package.loaded) do
    if k:match(".*caironoon.*") then package.loaded[k] = nil end
end

require('caironoon').setup()
require('caironoon').colorscheme()
