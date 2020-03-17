#https://pypi.org/project/anvil-parser/
#https://pypi.org/project/NBT/
#https://pypi.org/project/frozendict/

import anvil

print('Enter path to .mca file')
region = anvil.Region.from_file(input())
chunk = anvil.Chunk.from_region(region, 0, 0)
blocks=''

for ix in range(1,16):
    for iy in range(1,256):
        for iz in range(1,16):
            block = chunk.get_block(ix,iy,iz)
            if block.id != 'air':
                blocks+=str(ix)+','+str(iy)+','+str(iz)+'\n'

f = open("converted.txt", "w")
f.write(blocks)
f.close()
                
