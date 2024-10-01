# Importing necessary libraries and starting pygame
import pygame
import random

pygame.init()

# Defining colors
BLACK = (0, 0, 0)
WHITE = (255, 255, 255)
ASIANWHITE = (225, 228, 250)
GREEN = (24, 46, 0)
LIGHTGREEN = (42, 79, 0)
RED = (255, 0, 0)
LIGHTRED = (250, 85, 85)
PERRED = (117, 0, 0)
PURPLE = (115, 0, 150)
LIGHTPURPLE = (228, 138, 255)
BLUE = (0, 0, 255)
LIGHTBLUE = (179, 185, 255)
SKY = (1, 7, 48)
BROWN = (69, 17, 14)
ORANGE = (240, 158, 26)
SECONDBROWN = (115, 65, 30)
YELLOW = (255, 226, 41)


# Function to draw a star
def starfunc(cor1, cor2, size):
  pygame.draw.polygon(
      DISPLAYSURF, YELLOW,
      [[cor1, cor2], [cor1 - size, cor2 + 2 * size], [cor1, cor2 + 4 * size],
       [cor1 + size, cor2 + 2 * size]])


# Function to draw snowflakes
def snow(cor1, cor2):
  pygame.draw.line(DISPLAYSURF, WHITE, [cor1, cor2], [cor1, cor2 - 4], 2)
  pygame.draw.line(DISPLAYSURF, WHITE, [cor1, cor2], [cor1 + 4, cor2 - 1], 3)
  pygame.draw.line(DISPLAYSURF, WHITE, [cor1, cor2], [cor1 - 4, cor2 - 1], 3)
  pygame.draw.line(DISPLAYSURF, WHITE, [cor1, cor2], [cor1 + 2, cor2 + 4], 3)
  pygame.draw.line(DISPLAYSURF, WHITE, [cor1, cor2], [cor1 - 2, cor2 + 4], 3)
  pygame.draw.circle(DISPLAYSURF, WHITE, [cor1, cor2], 1)


# Function to draw Christmas balls
def balls(cor1, color):
  pygame.draw.circle(DISPLAYSURF, color[0], cor1, 15)
  pygame.draw.circle(DISPLAYSURF, color[1], cor1, 5)


# Function to draw presents
def present(cor, color, size):
  pygame.draw.rect(DISPLAYSURF, color[0], [cor[0], cor[1], size, size])
  pygame.draw.rect(DISPLAYSURF, color[1],
                   [cor[0] + size / 2 - 7, cor[1] - 5, 14, size + 10])
  pygame.draw.rect(DISPLAYSURF, color[1],
                   [cor[0] - 5, cor[1] + size / 2 - 7, size + 10, 14])
  pygame.draw.ellipse(DISPLAYSURF, WHITE,
                      [cor[0] - 20, cor[1] + size - 8, size + 40, 50])


# Setting up the display
DISPLAYSURF = pygame.display.set_mode([500, 590])

# Setting the window caption
pygame.display.set_caption("Christmas Gift Card")

# creating clock and font
clock = pygame.time.Clock()
font = pygame.font.Font(None, 75)
text = font.render("Happy Christmas!", True, RED)
num = 0


def cloud(coor):
  pygame.draw.ellipse(DISPLAYSURF, ASIANWHITE, [coor, 50, 200, 70])
  pygame.draw.ellipse(DISPLAYSURF, ASIANWHITE, [coor, 50, 70, 70])
  pygame.draw.ellipse(DISPLAYSURF, ASIANWHITE, [coor + 80, 30, 80, 70])
  pygame.draw.ellipse(DISPLAYSURF, ASIANWHITE, [coor + 110, 18, 100, 100])


while True:

  for event in pygame.event.get():
    if event.type == pygame.QUIT:
      pygame.quit()

  DISPLAYSURF.fill(SKY)

  # Drawing ground and tree structure
  pygame.draw.rect(DISPLAYSURF, WHITE, [0, 500, 700, 500])
  pygame.draw.rect(DISPLAYSURF, BROWN, [120, 400, 70, 100])
  pygame.draw.polygon(DISPLAYSURF, WHITE, [[-1, 430], [310, 430], [155, 225]])
  pygame.draw.polygon(DISPLAYSURF, WHITE, [[25, 340], [285, 340], [155, 145]])
  pygame.draw.polygon(DISPLAYSURF, WHITE, [[50, 250], [260, 250], [155, 95]])

  # Drawing layers of the tree
  pygame.draw.polygon(DISPLAYSURF, GREEN, [[5, 430], [305, 430], [155, 230]])
  pygame.draw.polygon(DISPLAYSURF, GREEN, [[30, 340], [280, 340], [155, 150]])
  pygame.draw.polygon(DISPLAYSURF, GREEN, [[55, 250], [255, 250], [155, 100]])

  pygame.draw.polygon(DISPLAYSURF, LIGHTGREEN,
                      [[25, 420], [285, 420], [155, 240]])
  pygame.draw.polygon(DISPLAYSURF, LIGHTGREEN,
                      [[50, 330], [260, 330], [155, 160]])
  pygame.draw.polygon(DISPLAYSURF, LIGHTGREEN,
                      [[75, 240], [235, 240], [155, 110]])

  # Drawing stars on the tree
  starfunc(155, 60, 10)
  starfunc(32, 340, 8)
  starfunc(278, 340, 8)
  starfunc(32, 340, 8)
  starfunc(57, 250, 8)
  starfunc(253, 250, 8)

  # Drawing snow on the ground
  pygame.draw.ellipse(DISPLAYSURF, WHITE, [-200, 460, 300, 100])
  pygame.draw.ellipse(DISPLAYSURF, WHITE, [50, 460, 300, 100])
  pygame.draw.ellipse(DISPLAYSURF, WHITE, [300, 470, 300, 100])

  # Drawing snowman structure
  pygame.draw.line(DISPLAYSURF, SECONDBROWN, [375, 300], [318, 367], 10)
  pygame.draw.line(DISPLAYSURF, SECONDBROWN, [425, 300], [482, 367], 10)
  pygame.draw.circle(DISPLAYSURF, WHITE, [405, 440], 70)
  pygame.draw.circle(DISPLAYSURF, WHITE, [405, 330], 50)
  pygame.draw.circle(DISPLAYSURF, WHITE, [405, 260], 30)
  pygame.draw.circle(DISPLAYSURF, BLACK, [392, 255], 5)
  pygame.draw.circle(DISPLAYSURF, BLACK, [418, 255], 5)
  pygame.draw.polygon(DISPLAYSURF, ORANGE,
                      [[405, 265], [410, 275], [380, 275]])

  # Drawing buttons on the snowman
  for i in range(310, 440, 40):
    pygame.draw.circle(DISPLAYSURF, BLACK, [405, i + random.randint(-5, 5)], 5)

  # Drawing the snowman's hat
  pygame.draw.polygon(DISPLAYSURF, RED, [[380, 240], [430, 240], [405, 190]])
  pygame.draw.rect(DISPLAYSURF, ASIANWHITE, [380, 235, 50, 10])
  pygame.draw.circle(DISPLAYSURF, ASIANWHITE, [417, 185], 15)
  pygame.draw.rect(DISPLAYSURF, PERRED, [377, 279, 55, 11])

  # Drawing clouds in the sky
  cloud(250 - num)
  num += 10
  if num == 480:
    num = -300

  # Generating random positions for Christmas balls
  listOfBalls = [[100, 330], [180, 210], [220, 400], [80, 410], [190, 280],
                 [120, 270], [90, 230], [160, 150], [240, 320], [140, 360]]
  # Generating random colors for Christmas balls
  color = [[LIGHTBLUE, BLUE], [LIGHTRED, RED], [LIGHTPURPLE, PURPLE]]

  # Drawing Christmas balls
  for cor in listOfBalls:
    balls(cor, color[random.randint(0, 2)])

  # Drawing presents
  present([300, 450], [BLUE, LIGHTBLUE], 50)
  present([60, 460], [RED, LIGHTRED], 40)
  present([200, 440], [PURPLE, LIGHTPURPLE], 65)

  # Displaying text on the screen
  DISPLAYSURF.blit(text, [25, 15])

  # Generating snowflakes at random positions
  for x in range(0, 150):
    x = random.randint(0, 500)
    y = random.randint(0, 590)
    snow(x, y)

  # Updating the display
  pygame.display.update()
  clock.tick(8)

  # Checking for key press to exit the loop
  click = pygame.key.get_pressed()
  if click[pygame.K_SPACE]:
    break
