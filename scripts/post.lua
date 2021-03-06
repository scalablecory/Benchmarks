local pipelineDepth = 1

function readData(filename)
   local f = io.open(filename, "rb")
   local data = f:read("*a")
   f:close()
   return data
end

function init(args)
   local data = readData("scripts/data.txt")
   local contentLength = string.len(data)

   print("Reading data file: " .. contentLength .. " bytes" )
   wrk.method = "POST"
   wrk.body = data
   wrk.headers["Content-Type"] = "text/plain"
   wrk.headers["Content-Length"] = contentLength

   if args[1] ~= nil then
      pipelineDepth = args[1]
   end

   local r = {}
   for i = 1, pipelineDepth, 1 do
      r[i] = wrk.format()
   end

   print("Pipeline depth: " .. pipelineDepth)

   req = table.concat(r)
end

function request()
   return req
end
