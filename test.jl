#khoi tao man hinh choi game
HEIGHT = 300
WIDTH = 600
speed = 5
BACKGROUND = colorant"antiquewhite"
dino = Actor("dinosaur")
tree = Actor("tree")
map = Actor("Track")
tree1 = Actor("tree")
dino_vy = 5
GRAVITY = 0.02
dino_dead = false
dino.pos = (0,210)
tree.pos = (550,220)
map.pos = (0,250)
gameover= false
gameoverimg = Actor("GameOver")
gameoverimg.pos =(130,115)
score = 0
function collid() # xu li va cham
    global gameover
    if collide(dino, tree) 
        gameover = true

    end
end
function draw(g::Game) # ve nhan vat
    draw(dino)
    draw(tree)
    draw(map)
  
    
    if collide(dino, tree)
        dino_dead = true
        dino.image = "DinoDead"
        draw(gameoverimg)
    end
    txt = TextActor("score = $score", "comicbd";
            font_size = 25, color = Int[0, 128, 0, 255]
        )
        txt.pos = (10, 5)
        draw(txt)
    
end

function update() #update cac ham 
 
    update_map()
    update_tree()
 
    update_dino()
    collid()
    
end
function update_map() # map chuyen dong
    
    if gameover==false
        map.x = map.x- speed
         if map.x <= -100
             map.x=0
         end
    end
    
 end
     
 
 function update_tree() # cay chuyen dong
    if gameover ==false
        tree.x = tree.x-speed
        if tree.x <0
            tree.x=500
            global score += 1
        end
    end
end

 function update_dino() # khong long nhay
    global dino_vy
    uy = dino_vy
    dino_vy = dino_vy + GRAVITY  
    dino.x = 0
    if dino.y< 210
        dino.y += Int(round((uy + dino_vy)/3)) # van toc roi
    end
 end

 function reset() # reset game
    global dino, map , tree
    dino = Actor("dinosaur")
    tree.pos = (550,220)
    map.pos = (0,250)
    dino.pos = (0,210)
    global dino_vy, GRAVITY
    dino_vy = 5
    GRAVITY = 0.01
    global gameover
    gameover = false
    global score 
    score =0
 end

 function on_key_down(g::Game) # ban phim
    if g.keyboard.SPACE
        if dino.y >= 210
            dino.y -=125
            if gameover ==true
                reset()
            end
        end
       
    end
   
end

