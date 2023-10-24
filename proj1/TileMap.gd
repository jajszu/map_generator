extends TileMap

@export var seed : int 
@export var radius : int

@export var chances = {
	0: {"grass": 40,"sand" : 5, "rock": 3, "water": 5},
	1: {"grass": 3,"sand" : 60, "rock": 10, "water": 10},
	2: {"grass": 50,"sand" : 50, "rock": 30, "water": 10},
	3: {"grass": 20,"sand" : 20, "rock": 0, "water": 80}
	 }
func generate():
	seed(seed)
	var size : int = 2*radius+1
	var tiles = []
	for x in size:
		tiles.append([])
		for y in size:
			tiles[x].append(-1)
	for x in size:
		for y in size:
			while true:
				if x==0 && y==0:
					tiles[x][y] = randi_range(0,3)
					break
				if y==0:
					if chances[tiles[x-1][y]]["grass"] >= randi_range(0,100):
						tiles[x][y] = 0
						break
					if chances[tiles[x-1][y]]["sand"] >= randi_range(0,100):
						tiles[x][y] = 1
						break
					if chances[tiles[x-1][y]]["rock"] >= randi_range(0,100):
						tiles[x][y] = 2
						break
					if chances[tiles[x-1][y]]["water"] >= randi_range(0,100):
						tiles[x][y] = 3
						break
				if x == 0:
					if chances[tiles[x][y-1]]["grass"] >= randi_range(0,100):
						tiles[x][y] = 0
						break
					if chances[tiles[x][y-1]]["sand"] >= randi_range(0,100):
						tiles[x][y] = 1
						break
					if chances[tiles[x][y-1]]["rock"] >= randi_range(0,100):
						tiles[x][y] = 2
						break
					if chances[tiles[x][y-1]]["water"] >= randi_range(0,100):
						tiles[x][y] = 3
						break
				if x>0 && y>0:
					if (chances[tiles[x][y-1]]["grass"]+chances[tiles[x-1][y]]["grass"])/2 >= randi_range(0,100):
						tiles[x][y] = 0
						break
					if (chances[tiles[x][y-1]]["sand"]+chances[tiles[x-1][y]]["sand"])/2 >= randi_range(0,100):
						tiles[x][y] = 1
						break
					if (chances[tiles[x][y-1]]["rock"]+chances[tiles[x-1][y]]["rock"])/2 >= randi_range(0,100):
						tiles[x][y] = 2
						break
					if (chances[tiles[x][y-1]]["water"]+chances[tiles[x-1][y]]["water"])/2 >= randi_range(0,100):
						tiles[x][y] = 3
						break
	for x in size:
		for y in radius/3:
			if randi_range(0,radius/3)<=radius/3-y:
				tiles[x][y] = 3
	for x in size:
		for y in range(size-radius/3,size):
			if randi_range(size-radius/3,size)<=y:
				tiles[x][y] = 3
	for y in size:
		for x in radius/3:
			if randi_range(0,radius/3)<=radius/3-x:
				tiles[x][y] = 3
	for y in size:
		for x in range(size-radius/3,size):
			if randi_range(size-radius/3,size)<=x:
				tiles[x][y] = 3
	
	for x in range(1,size-1):
		for y in range(1,size-1):
			var coneccted = 4
			if tiles[x-1][y] == 3:
				coneccted-=1
			if tiles[x+1][y] == 3:
				coneccted-=1
			if tiles[x][y-1] == 3:
				coneccted-=1
			if tiles[x][y+1] == 3:
				coneccted-=1
			if coneccted<=1:
				tiles[x][y] = 3
	for x in size:
		if tiles[x][0] != 3:
			tiles[x][0] = 3
		if tiles[0][x] != 3:
			tiles[0][x] = 3
		if tiles[x][size-1] != 3:
			tiles[x][size-1] = 3
		if tiles[size-1][x] != 3:
			tiles[size-1][x] = 3
	for x in size:
		for y in size:
			set_cell(0,Vector2i(x,y),0,Vector2i(0,tiles[x][y]))
# Called when the node enters the scene tree for the first time.
func _ready():
	generate()
func _process(delta):
	if Input.is_action_just_pressed("g"):
		seed = randi()
		generate()
		


