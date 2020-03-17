local kf={}
kf.itypes={
  ['cube']='nil',
  ['crate']=1,
  ['ramp']=9,
  ['sphere']=34,
}
kf.textures={
  ['wall']='nil',
  ['dirt']=1,
  ['floor']=2,
  ['grid']=3,
  ['grey']=4,
  ['default']=5,
  ['roof']=6,
  ['flag']=7,
  ['check']=8,
  ['grass']=9,
  ['lines']=10,
  ['brick']=11,
  ['link']=12,
}

function kf.read(data)
  local arr=json.decode('['..data..']')
  return arr[1]
end

function kf.write(data)
  return json.encode(data)
end

function kf.createObj(data,pos,size,color,itype,texture,rotation)
  if not data then return nil end

  pos=pos or {0,0,0}
  if type(itype)=='string' then
    itype=kf.itypes[itype]
  end
  if type(texture)=='string' then
    texture=kf.textures[texture]
  end

  local objl=data.objects--[1]
  local oid=#objl+1
  objl[oid]={p=pos,s=size,i=itype,t=texture,r=rotation}

  return oid
end

return kf
