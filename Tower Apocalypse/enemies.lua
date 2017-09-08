
enemiesTypes = {}

--enemiesTypes [1] =  display.newImage("zombie.png")	
			--enemiesTypes[1].anchorX=0
			--enemiesTypes[1].anchorY=0
			--enemiesTypes[1].x = (0)*64
			--enemiesTypes[1].y =  (0)* 64
			enemiesTypes.speed = 925
			enemiesTypes.health = 100
			enemiesTypes.lastX =0
			enemiesTypes.lastY =0
			enemiesTypes.id = 1
			enemiesTypes.type = 1
			enemiesTypes.timer = 0
			enemiesTypes.cooldown = 30
			enemiesTypes.resource = 10
			enemiesTypes.damage = 10
			--physics.addBody(enemiesTypes[1],"static",{density = .1,bounce = 0.1,friction = .2,radius = 20 })








--[[enemySpawned[aCounter] = display.newImage("zombie.png")	
			enemySpawned[aCounter].anchorX=0
			enemySpawned[aCounter].anchorY=0
			enemySpawned[aCounter].x = (0)*64
			enemySpawned[aCounter].y =  (x1-1)* 64
			enemySpawned[aCounter].speed = 2650
			enemySpawned[aCounter].health = 100
			enemySpawned[aCounter].lastX =0
			enemySpawned[aCounter].lastY =0
			enemySpawned[aCounter].id = aCounter
			enemySpawned[aCounter].timer = 0
			enemySpawned[aCounter].resource = 30
			physics.addBody(enemySpawned[aCounter],"static",{density = .1,bounce = 0.1,friction = .2,radius = 20 })]]--

return enemiesTypes