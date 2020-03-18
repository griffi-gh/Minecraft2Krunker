#https://pypi.org/project/anvil-parser/
#https://pypi.org/project/NBT/
#https://pypi.org/project/frozendict/

import anvil

print('Enter path to .mca file')
region = anvil.Region.from_file(input())
chunk = anvil.Chunk.from_region(region, 0, 0)
blocks=''

it=0
ip=0
for ix in range(0,16):
    for iz in range(0,16):
        for iy in range(0,256):
            it+=1
            if it%2000==0:
                print('converting... '+str(it)+'/'+str(16*256*16))
            block = chunk.get_block(ix,iy,iz)
            if block.id != 'air':
                ip+=1
                blocks+=str(ix)+','+str(iy)+','+str(iz)+'\n'   

print(str(ip)+' '+str(it))
f = open("converted.txt", "w")
f.write(blocks)
f.close()
                
