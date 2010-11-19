function showBlocks(dec, img)
blocks = repmat(uint8(0),size(dec));

for dim = [512 256 128 64 32 16 8 4 2 1];    
  numblocks = length(find(dec==dim));    
  if (numblocks > 0)        
    values = repmat(uint8(1),[dim dim numblocks]);
    values(2:dim,2:dim,:) = 0;
    blocks = qtsetblk(blocks,dec,dim,values);
  end
end

blocks(end,1:end) = 1;
blocks(1:end,end) = 1;

imshow(img), figure, imshow(blocks,[])
end