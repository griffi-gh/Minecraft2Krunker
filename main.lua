love.filesystem.setIdentity(love.filesystem.getIdentity(),true)

json=require"lib.json"
kf=require"krunkerFile"
dm='{"name":"MAP","ambient":"#97a0a8","light":"#f2f8fc","sky":"#dce8ed","fog":"#8d9aa0","fogD":2000,"objects":[],"spawns":[]}'

scroll=0

function nf(val) if val=='nil' then val=nil end return val end
function sym(str,sm) sm=(sm or '\n');return(str:gmatch("([^"..sm.."]*)"..sm.."?")) end

function readFile(name)
  local file=io.open(name,'r')
  local data=file:read('*a')
  io.close()
  return data
end

function writeFile(name,data)
  local file=io.open(name,'wb')
  local succ=file:write(data)
  io.close()
  return succ
end

function Val2id(t,v)
  for i,val in pairs(t) do
    val=nf(val)
    if val==v then
      return i
    end
  end
end

function readConverted(data)
  local blocks={}
  for line in sym(data) do
    if line:len()>1 then
      local c={}
      for s in sym(line,',') do
        c[#c+1]=tonumber(s)
      end
      blocks[#blocks+1]={x=c[1],y=c[2],z=c[3]}
    end
  end
  return blocks
end

function buildMap(ConvFile,krunkerMap)
  local data=readFile(ConvFile)
  local blocks=readConverted(data)
  local blSize=10
  for i,v in ipairs(blocks) do
    kf.createObj(krunkerMap,{v.x*blSize,v.y*blSize,v.z*blSize},{blSize,blSize,blSize},nil,nil,'default',nil)
  end
end

function love.draw()
  love.graphics.setColor(1,1,1,1-(scroll/1000)-0.7)
  love.graphics.rectangle('fill',(love.graphics.getWidth()/2)-12,0,love.graphics.getWidth(),love.graphics.getHeight())
  love.graphics.setColor(1,1,1)
  for i,v in ipairs(MAP.objects) do
    love.graphics.print('itype:'..(Val2id(kf.itypes,v.i) or 'uknown')..' texture:'..(Val2id(kf.textures,v.t) or 'uknown')..' x:'..v.p[1]..' y:'..v.p[2]..' z:'..v.p[3],0,((i-1)*12)-scroll)
  end

  love.graphics.print('\n\nMC2Krunker\n\n=======================\nUSE convert.py TO CONVERT MCA FILE\n=======================\nENTER-GENERATE(converted.txt)\nS-CONVERT AND SAVE (OUTPUT.txt)\nMOUSE WHEEL-SCROLL\n=======================',
  love.graphics.getWidth()/2,-scroll)
end

function love.update(dt)
  scroll=math.min(scroll,((#(MAP.objects or {objects={}})+1)*12)-love.graphics.getHeight())
  scroll=math.max(scroll,0)
end

function love.load(arg)
  MAP=kf.read(dm)
  love.window.setTitle('MC2Krunker')
end

function love.keypressed(key, scancode, isrepeat)
  local export=kf.write(MAP)
  if(key=="return")then
    buildMap('converted.txt',MAP)
  elseif(key=="s")then
    writeFile('OUTPUT.txt',export)
  end
end

function love.wheelmoved(x, y)
    if y > 0 then
        scroll=scroll-12*3
    elseif y < 0 then
        scroll=scroll+12*3
    end
end
