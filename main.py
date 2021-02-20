import json
import numpy as np
import matplotlib.pyplot as plt

f = open("multiBody_chaos\data.json", "r")
data = json.load(f)

time = data[0]
dist = data[1]
acc = data[2]
accX = data[3]
accY = data[4]
vel = data[5]
velX = data[6]
velY = data[7]
posX = data[8]
posY = data[9]

plt.plot(time, dist)
plt.show()
