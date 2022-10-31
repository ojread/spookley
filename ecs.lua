--ecs

world={}

function _has(e,ks)
 for n in all(ks) do
  if not e[n] then
   return false
  end
 end
 return true
end

function system(ks, f)
 return function(es)
  for e in all(es) do
   if _has(e, ks) then
    f(e)
   end
  end
 end
end

function tag(e,k,v)
 e[k]=v
end

function untag(e,k)
 e[k]=nil
end

function filter(es,k,v)
 local res={}
 for e in all(es) do
  if e[k]==v then
   add(res,e)
  end
 end
 return res
end

function find(es,k,v)
 local res=filter(es,k,v)
 if (#res>0) return res[1]
 return nil
end

function filter_tagged(es,t)
 local res={}
 for e in all(es) do
  if e[t]!=nil then
   add(res,e)
  end
 end
 return res
end