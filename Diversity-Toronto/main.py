import math
import random
import pygame

#intializing the game
pygame.init()
screen = pygame.display.set_mode([710, 380])
pygame.display.set_caption("Diversity in Toronto")

#setting the colors
WHITE = (255, 255, 255)
BLACK = (0, 0, 0)
RED = (255, 0, 0)
GREEN = (0, 255, 0)
BLUE = (0, 0, 255)
YELLOW = (255, 255, 0)
Gold = (233, 173, 3)
GREY = (148, 148, 148)

#loading the images into the game
toronto = pygame.image.load("toronto.png").convert()
welcomePage_pic = pygame.image.load("welcome page.png").convert()
welcomePage_pic = pygame.transform.scale_by(welcomePage_pic, 0.85)
toronto_skyline = pygame.image.load("Toronto-skyline.jpg").convert()
toronto_skyline = pygame.transform.scale(toronto_skyline, [710, 382])
wilowdale_picture = pygame.image.load("wilowdale.jpeg").convert()
wilowdale_picture = pygame.transform.scale(wilowdale_picture, [710, 470])
persian_woman_picture = pygame.image.load("Persian Women.png").convert()
persian_woman_picture = pygame.transform.scale_by(persian_woman_picture, 0.4)
persian_woman_picture.set_colorkey(WHITE)
persianRugCoasters_pic = pygame.image.load(
    "Persian rug coasters.png").convert()
persianRugCoasters_pic = pygame.transform.scale(persianRugCoasters_pic,
                                                [170, 170])
persianRugCoasters_pic.set_colorkey(WHITE)
persianTeaSet_pic = pygame.image.load("Persian Tea Set.png").convert()
persianTeaSet_pic.set_colorkey(WHITE)
persianTeaSet_pic = pygame.transform.scale(persianTeaSet_pic, [170, 170])
saffron_pic = pygame.image.load("Saffron.png").convert()
saffron_pic = pygame.transform.scale(saffron_pic, [190, 190])
saffron_pic.set_colorkey(WHITE)
torontoDowntown_pic = pygame.image.load("Toronto Downtown.jpg").convert()
torontoDowntown_pic = pygame.transform.scale_by(torontoDowntown_pic, 0.15)
homelessMan_pic = pygame.image.load("Homeless man.png").convert()
homelessMan_pic.set_colorkey(WHITE)
homelessMan_pic = pygame.transform.scale_by(homelessMan_pic, 0.4)
homelessCandless_pic = pygame.image.load(
    "homeless candless.png").convert_alpha()
homelessCandless_pic = pygame.transform.scale(homelessCandless_pic, [190, 190])
toteBag_pic = pygame.image.load("Tote bag.png").convert_alpha()
toteBag_pic = pygame.transform.scale(toteBag_pic, [200, 200])
musicCollection_pic = pygame.image.load("Music Colection.png").convert_alpha()
musicCollection_pic = pygame.transform.scale(musicCollection_pic, [190, 190])
etobicokeNorth_pic = pygame.image.load("Etobicoke North.jpg").convert()
etobicokeNorth_pic = pygame.transform.scale_by(etobicokeNorth_pic, 0.75)
irishMan_pic = pygame.image.load("Irish man.png").convert()
irishMan_pic.set_colorkey(WHITE)
irishMan_pic = pygame.transform.scale_by(irishMan_pic, 0.4)
irishJewelry_pic = pygame.image.load("Irish Jewelry.png").convert_alpha()
irishJewelry_pic = pygame.transform.scale(irishJewelry_pic, [190, 190])
irishJewelry_pic.set_colorkey(WHITE)
irishFlatCap_pic = pygame.image.load("Irish Flat Cap.png").convert_alpha()
irishFlatCap_pic = pygame.transform.scale(irishFlatCap_pic, [190, 190])
sodaBreadMix_pic = pygame.image.load("Soda Bread mix.png").convert_alpha()
sodaBreadMix_pic = pygame.transform.scale(sodaBreadMix_pic, [190, 190])
wilowdaleTalking_pic = pygame.image.load("wilowdale_talking.png").convert()
wilowdaleTalking_pic.set_colorkey(BLACK)
wilowdaleTalking_pic = pygame.transform.scale_by(wilowdaleTalking_pic, 0.3)
airplaneIcon_pic = pygame.image.load("airplane icon.png").convert_alpha()
airplaneIcon_pic = pygame.transform.scale(airplaneIcon_pic, [50, 50])
airplaneDeparture_pic = pygame.image.load("airplane departure.jpg").convert()
shockedPerson_pic = pygame.image.load("shocked person.png").convert_alpha()
shockedPerson_pic = pygame.transform.scale_by(shockedPerson_pic, 0.4)
pos1_diouloge = pygame.image.load("pos1diouloge.png").convert()
pos1_diouloge = pygame.transform.scale_by(pos1_diouloge, 0.4)
pos1_diouloge.set_colorkey(BLACK)
finalLevel_diouloge = pygame.image.load("final level diouloge.png").convert()
finalLevel_diouloge.set_colorkey(BLACK)
finalLevel_diouloge = pygame.transform.scale_by(finalLevel_diouloge, 0.4)
pos2_diouloge = pygame.image.load("pos2 diouloge.png").convert()
pos2_diouloge.set_colorkey(BLACK)
pos2_diouloge = pygame.transform.scale_by(pos2_diouloge, 0.4)
pos3_diouloge = pygame.image.load("pos3 diouloge.png").convert()
pos3_diouloge.set_colorkey(BLACK)
pos3_diouloge = pygame.transform.scale_by(pos3_diouloge, 0.4)
skeleton = pygame.image.load("skeleton.png").convert_alpha()
skeleton = pygame.transform.scale_by(skeleton, 0.4)
pos4_diouloge = pygame.image.load("pos4 diouloge.png").convert()
pos4_diouloge.set_colorkey(BLACK)
pos4_diouloge = pygame.transform.scale_by(pos4_diouloge, 0.4)
flightattendan_pic = pygame.image.load("flight attendant.png").convert_alpha()
flightattendan_pic = pygame.transform.scale_by(flightattendan_pic, 0.4)
torontoCenter_diouloge = pygame.image.load(
    "toronto center diouloge.png").convert()
torontoCenter_diouloge = pygame.transform.scale_by(torontoCenter_diouloge, 0.3)
torontoCenter_diouloge.set_colorkey(BLACK)
start_pic = pygame.image.load("start.png").convert_alpha()
start_pic = pygame.transform.scale(start_pic, [66, 66])
etobicokeLakeshore_diouloge = pygame.image.load(
    "etobikoce lakeshore diouloge.png").convert()
etobicokeLakeshore_diouloge = pygame.transform.scale_by(
    etobicokeLakeshore_diouloge, 0.4)
etobicokeLakeshore_diouloge.set_colorkey(BLACK)
scarbroughAgincourt_pic = pygame.image.load(
    "scarbrough agincourt.jpg").convert()
scarbroughAgincourt_pic = pygame.transform.scale_by(scarbroughAgincourt_pic,
                                                    0.4)
chineseMan_pic = pygame.image.load("Chinese man.png").convert()
chineseMan_pic.set_colorkey(WHITE)
chineseMan_pic = pygame.transform.scale_by(chineseMan_pic, 0.4)
scarbroughAgincourt_diouloge = pygame.image.load(
    "scarbroughAgincourt diouloge.png").convert_alpha()
scarbroughAgincourt_diouloge = pygame.transform.scale_by(
    scarbroughAgincourt_diouloge, 0.75)
chineseFan_pic = pygame.image.load("Chinese Fan.png").convert()
chineseFan_pic = pygame.transform.scale(chineseFan_pic, [190, 190])
chineseFan_pic.set_colorkey(WHITE)
chineseLuckyCat_pic = pygame.image.load(
    "Chinese Lucky Cat.png").convert_alpha()
chineseLuckyCat_pic = pygame.transform.scale(chineseLuckyCat_pic, [190, 190])
chineseTeaSet_pic = pygame.image.load("Chinese tea set.png").convert_alpha()
chineseTeaSet_pic = pygame.transform.scale(chineseTeaSet_pic, [190, 190])
yorkSouth_background = pygame.image.load("yorkSouth background.jpg").convert()
yorkSouth_background = pygame.transform.scale_by(yorkSouth_background, 0.35)
italianMan_pic = pygame.image.load("italian man.png").convert_alpha()
italianMan_pic = pygame.transform.scale_by(italianMan_pic, 0.4)
yorkSouth_diouloge = pygame.image.load("YorkSouth diouloge.png").convert()
yorkSouth_diouloge.set_colorkey(BLACK)
yorkSouth_diouloge = pygame.transform.scale_by(yorkSouth_diouloge, 0.3)
oliveOil_pic = pygame.image.load("olive oil.png").convert_alpha()
oliveOil_pic = pygame.transform.scale(oliveOil_pic, [190, 190])
esspresso_pic = pygame.image.load("esspresso.png").convert_alpha()
esspresso_pic = pygame.transform.scale(esspresso_pic, [190, 190])
pasta_pic = pygame.image.load("pasta.png").convert_alpha()
pasta_pic = pygame.transform.scale(pasta_pic, [190, 190])

#asigning fonts
knowledgeFont = pygame.font.Font(None, 25)


#creating a funciton to check circle areas
def CircleMouseCheck(circle_rad, circle_cor):
  pos = pygame.mouse.get_pos()
  distance = math.sqrt((pos[0] - circle_cor[0] - circle_rad)**2 +
                       (pos[1] - circle_cor[1] - circle_rad)**2)
  # pygame.draw.circle(screen, YELLOW, [circle_cor[0] + circle_rad, circle_cor[1] + circle_rad], circle_rad, 2)
  return distance <= circle_rad


#create a function for stats(money and satisfaction)
class Stats():

  def __init__(self, satisfaction, money):
    super().__init__()
    self.satisfaction = satisfaction
    self.money = money
    self.font = pygame.font.Font(None, 25)

  #adding the check if a person is alive or not
  def aliveCheck(self):
    #making sure the stats don't drop under 0
    if self.money < 0:
      self.money = 0
    if self.satisfaction < 0:
      self.satisfaction = 0
    #printing a message if the person died
    if (self.satisfaction <= 30) or (self.money <= 0):
      screen.fill(WHITE)
      text = self.font.render(
          "AWWW! You have died! well... Good luck playing next time!", True,
          BLACK)
      screen.blit(text, [80, 145])
      print("\nThis is why you died... :)")
      print("Money = ", status.money, "/Satisfaction =", status.satisfaction)
      pygame.display.update()
      global run
      run = False


#randomizing the stats for a person
status = Stats(random.randint(40, 100), random.randint(40, 70))


#creating the welcomePage class for the begining
class welcomePage():

  def __init__(self, y):
    super().__init__()
    self.y = y

  def show(self):
    screen.fill(BLACK)
    screen.blit(welcomePage_pic, [10, self.y])


#creating the toronto background class
class TorontoBckground():

  def __init__(self):
    super().__init__()

  def show(self):
    screen.blit(toronto, [0, 0])
    pygame.draw.circle(screen, RED, [320, 60], 12)
    pygame.draw.circle(screen, RED, [316, 278], 12)
    pygame.draw.circle(screen, RED, [105, 272], 12)
    pygame.draw.circle(screen, RED, [460, 60], 12)
    pygame.draw.circle(screen, RED, [182, 175], 12)


#creating the wilowdale class
class Wilowdale():

  def __init__(self):
    super().__init__()
    self.current_time = pygame.time.get_ticks
    self.finished = False

  #making the function show so that I just call it on all classes
  def show(self):
    screen.blit(wilowdale_picture, [0, -40])

  #creating the knowledge function for the start of a neighbourhood
  def knowledge(self):
    global new_time
    global position
    self.current_time = pygame.time.get_ticks()
    #making sure the function just runs for a specific time
    if self.current_time < new_time:
      screen.blit(persian_woman_picture, [500, 215])
      screen.blit(wilowdaleTalking_pic, [50, 50])
    elif self.current_time > new_time:
      position += 1

  #defininng the souvenir class
  def souvenir(self):
    screen.blit(persianRugCoasters_pic, [480, 35])
    screen.blit(persianTeaSet_pic, [60, 35])
    screen.blit(saffron_pic, [255, 130])
    global current_map_no
    global finishedAmnt
    #checking if the user has pressed the souvenirs and adding satisfaction and lowering money
    if CircleMouseCheck(82, [480, 35]):
      #if the user hovers over an object it shows the price and satisfaction point
      pygame.draw.rect(screen, WHITE, [520, 205, 90, 20])
      text1 = knowledgeFont.render(" 25$ - 6 SP", True, BLACK)
      screen.blit(text1, [520, 205])
      #checking if they pressed the item
      if pygame.mouse.get_pressed()[0]:
        #affecting money and satisfaction points. Changing "finished" to "True" and updating the background to Toronto.
        self.finished = True
        status.money -= 25
        status.satisfaction += 6
        current_map_no = 1
        finishedAmnt += 1
    #doing the same for other souvenir items
    elif CircleMouseCheck(85, [60, 35]):
      pygame.draw.rect(screen, WHITE, [100, 205, 90, 24])
      text1 = knowledgeFont.render(" 50$ - 10 SP", True, BLACK)
      screen.blit(text1, [100, 205])
      if pygame.mouse.get_pressed()[0]:
        self.finished = True
        status.money -= 50
        status.satisfaction += 10
        current_map_no = 1
        finishedAmnt += 1
    #doing the same for other souvenir items
    elif CircleMouseCheck(90, [260, 135]):
      pygame.draw.rect(screen, WHITE, [302, 320, 90, 20])
      text1 = knowledgeFont.render(" 35$ - 8 SP", True, BLACK)
      screen.blit(text1, [302, 320])
      if pygame.mouse.get_pressed()[0]:
        self.finished = True
        current_map_no = 1
        status.money -= 35
        status.satisfaction += 8
        finishedAmnt += 1


#doing the same for other neighbourhoods
class TorontoCenter(Wilowdale):

  def show(self):
    screen.blit(torontoDowntown_pic, [-50, -70])

  def knowledge(self):
    global new_time
    global position
    self.current_time = pygame.time.get_ticks()
    if self.current_time < new_time:
      screen.blit(homelessMan_pic, [500, 188])
      screen.blit(torontoCenter_diouloge, [50, 50])
    elif self.current_time > new_time:
      position += 1

  def souvenir(self):
    screen.blit(homelessCandless_pic, [480, 35])
    screen.blit(toteBag_pic, [60, 35])
    screen.blit(musicCollection_pic, [255, 130])
    global current_map_no
    global finishedAmnt
    if CircleMouseCheck(88, [480, 35]):
      pygame.draw.rect(screen, WHITE, [520, 205, 90, 20])
      text1 = knowledgeFont.render(" 15$ - 4 SP", True, BLACK)
      screen.blit(text1, [520, 205])
      if pygame.mouse.get_pressed()[0]:
        self.finished = True
        status.money -= 15
        status.satisfaction += 4
        current_map_no = 1
        finishedAmnt += 1
    elif CircleMouseCheck(80, [80, 50]):
      pygame.draw.rect(screen, WHITE, [100, 205, 90, 20])
      text1 = knowledgeFont.render(" 20$ - 5 SP", True, BLACK)
      screen.blit(text1, [100, 205])
      if pygame.mouse.get_pressed()[0]:
        self.finished = True
        status.money -= 20
        status.satisfaction += 5
        current_map_no = 1
        finishedAmnt += 1
    elif CircleMouseCheck(90, [260, 135]):
      pygame.draw.rect(screen, WHITE, [302, 320, 90, 20])
      text1 = knowledgeFont.render(" 30$ - 6 SP", True, BLACK)
      screen.blit(text1, [302, 320])
      if pygame.mouse.get_pressed()[0]:
        self.finished = True
        status.money -= 30
        status.satisfaction += 6
        current_map_no = 1
        finishedAmnt += 1


#doing the same for other neighbourhoods
class EtobicokeNorth(Wilowdale):

  def show(self):
    screen.blit(etobicokeNorth_pic, [0, -90])

  def knowledge(self):
    global new_time
    global position
    self.current_time = pygame.time.get_ticks()
    if self.current_time < new_time:
      screen.blit(irishMan_pic, [0, 188])
      screen.blit(etobicokeLakeshore_diouloge, [90, 20])
    elif self.current_time > new_time:
      position += 1

  def souvenir(self):
    screen.blit(irishJewelry_pic, [480, 35])
    screen.blit(irishFlatCap_pic, [60, 35])
    screen.blit(sodaBreadMix_pic, [255, 130])
    global current_map_no
    global finishedAmnt
    if CircleMouseCheck(88, [485, 40]):
      pygame.draw.rect(screen, WHITE, [520, 210, 90, 20])
      text1 = knowledgeFont.render(" 60$ - 12 SP", True, BLACK)
      screen.blit(text1, [520, 210])
      if pygame.mouse.get_pressed()[0]:
        self.finished = True
        status.money -= 60
        status.satisfaction += 12
        current_map_no = 1
        finishedAmnt += 1
    elif CircleMouseCheck(90, [65, 40]):
      pygame.draw.rect(screen, WHITE, [100, 210, 90, 20])
      text1 = knowledgeFont.render(" 35$ - 8 SP", True, BLACK)
      screen.blit(text1, [100, 210])
      if pygame.mouse.get_pressed()[0]:
        self.finished = True
        status.money -= 35
        status.satisfaction += 8
        current_map_no = 1
        finishedAmnt += 1
    elif CircleMouseCheck(90, [255, 130]):
      pygame.draw.rect(screen, WHITE, [302, 320, 90, 20])
      text1 = knowledgeFont.render(" 20$ - 7 SP", True, BLACK)
      screen.blit(text1, [302, 320])
      if pygame.mouse.get_pressed()[0]:
        self.finished = True
        status.money -= 20
        status.satisfaction += 7
        current_map_no = 1
        finishedAmnt += 1


#doing the same for other neighbourhoods
class ScarbroughAgincourt(Wilowdale):

  def show(self):
    screen.blit(scarbroughAgincourt_pic, [0, -100])

  def knowledge(self):
    global new_time
    global position
    self.current_time = pygame.time.get_ticks()
    if self.current_time < new_time:
      screen.blit(chineseMan_pic, [500, 188])
      screen.blit(scarbroughAgincourt_diouloge, [30, 30])
    elif self.current_time > new_time:
      position += 1

  def souvenir(self):
    screen.blit(chineseFan_pic, [495, 35])
    screen.blit(chineseTeaSet_pic, [60, 35])
    screen.blit(chineseLuckyCat_pic, [255, 130])
    global current_map_no
    global finishedAmnt
    if CircleMouseCheck(92, [500, 40]):
      pygame.draw.rect(screen, WHITE, [540, 220, 90, 20])
      text1 = knowledgeFont.render(" 40$ - 8 SP", True, BLACK)
      screen.blit(text1, [540, 220])
      if pygame.mouse.get_pressed()[0]:
        self.finished = True
        status.money -= 40
        status.satisfaction += 8
        current_map_no = 1
        finishedAmnt += 1
    elif CircleMouseCheck(90, [65, 40]):
      pygame.draw.rect(screen, WHITE, [100, 220, 90, 20])
      text1 = knowledgeFont.render(" 30$ - 7 SP", True, BLACK)
      screen.blit(text1, [100, 220])
      if pygame.mouse.get_pressed()[0]:
        self.finished = True
        status.money -= 30
        status.satisfaction += 7
        current_map_no = 1
        finishedAmnt += 1
    elif CircleMouseCheck(94, [255, 130]):
      pygame.draw.rect(screen, WHITE, [302, 320, 90, 20])
      text1 = knowledgeFont.render(" 40$ - 8 SP", True, BLACK)
      screen.blit(text1, [302, 320])
      if pygame.mouse.get_pressed()[0]:
        self.finished = True
        status.money -= 40
        status.satisfaction += 8
        current_map_no = 1
        finishedAmnt += 1


#doing the same for other neighbourhoods
class YorkSouth_weston(Wilowdale):

  def show(self):
    screen.blit(yorkSouth_background, [0, -120])

  def knowledge(self):
    global new_time
    global position
    self.current_time = pygame.time.get_ticks()
    if self.current_time < new_time:
      screen.blit(italianMan_pic, [500, 188])
      screen.blit(yorkSouth_diouloge, [60, 30])
    elif self.current_time > new_time:
      position += 1

  def souvenir(self):
    screen.blit(oliveOil_pic, [495, 35])
    screen.blit(esspresso_pic, [60, 35])
    screen.blit(pasta_pic, [255, 130])
    global current_map_no
    global finishedAmnt
    if CircleMouseCheck(92, [500, 40]):
      pygame.draw.rect(screen, WHITE, [540, 220, 90, 20])
      text1 = knowledgeFont.render(" 55$ - 9 SP", True, BLACK)
      screen.blit(text1, [540, 220])
      if pygame.mouse.get_pressed()[0]:
        self.finished = True
        status.money -= 55
        status.satisfaction += 9
        current_map_no = 1
        finishedAmnt += 1
    elif CircleMouseCheck(90, [65, 40]):
      pygame.draw.rect(screen, WHITE, [100, 220, 90, 20])
      text1 = knowledgeFont.render(" 70$ - 10 SP", True, BLACK)
      screen.blit(text1, [100, 220])
      if pygame.mouse.get_pressed()[0]:
        self.finished = True
        status.money -= 70
        status.satisfaction += 10
        current_map_no = 1
        finishedAmnt += 1
    elif CircleMouseCheck(90, [255, 130]):
      pygame.draw.rect(screen, WHITE, [302, 320, 90, 20])
      text1 = knowledgeFont.render(" 40$ - 7 SP", True, BLACK)
      screen.blit(text1, [302, 320])
      if pygame.mouse.get_pressed()[0]:
        self.finished = True
        status.money -= 40
        status.satisfaction += 7
        current_map_no = 1
        finishedAmnt += 1


#creating the airport class for the final part of the game
class Airport():

  def __init__(self):
    super().__init__()
    self.current_time = pygame.time.get_ticks
    self.knowledge_complete = False

  #having the classes show and knowledge for simplicity
  def show(self):
    screen.blit(airplaneDeparture_pic, [0, 0])

  def knowledge(self):
    #making sure the end function doesnt run until knowledge is complete
    global new_time
    if not self.knowledge_complete:
      self.current_time = pygame.time.get_ticks()
      if self.current_time < new_time:
        screen.blit(finalLevel_diouloge, [100, 100])
      elif self.current_time > new_time:
        self.knowledge_complete = True

  #defining the end function for the different possiblities of the ending
  def end(self):
    global run
    if self.knowledge_complete:
      #randomizing the chance for the ending
      chance = random.randint(0, 4)
      if chance == 0:
        #adding elemnts to the screen for better visualisation
        screen.blit(shockedPerson_pic, [500, 188])
        screen.blit(pos1_diouloge, [100, 40])
        #affecting money and satisfaction and letting the user know how much they lost
        moneyLost = random.randint(50, 90)
        satisfactionLost = random.randint(50, 90)
        print(f"You lost, {moneyLost}$s in this sad event!")
        print(
            f"You lost, {satisfactionLost} satisfaction points in this sad event!"
        )
        pygame.display.update()
        status.money -= moneyLost
        status.satisfaction -= satisfactionLost
        #checking if they are alive
        status.aliveCheck()
        #if they stay alive, I would print a message and let them know
        if status.money > 0 and status.satisfaction > 0:
          print("\noh... It sounds like you didn't die :(")
          print("Money = ", status.money, "/Satisfaction =",
                status.satisfaction)
        pygame.time.delay(1000)
        run = False
      #doing the same for other endings
      elif chance == 1:
        screen.blit(shockedPerson_pic, [500, 188])
        screen.blit(pos2_diouloge, [100, 40])
        moneyLost = random.randint(20, 50)
        satisfactionLost = random.randint(20, 50)
        print(f"\nYou lost, {moneyLost}$s in this sad event!")
        print(
            f"You lost, {satisfactionLost} satisfaction points in this sad event!"
        )
        pygame.display.update()
        status.money -= moneyLost
        status.satisfaction -= satisfactionLost
        status.aliveCheck()
        if status.money > 0 and status.satisfaction > 0:
          print("oh... It sounds like you didn't die :(")
          print("Money = ", status.money, "/Satisfaction =",
                status.satisfaction)
        pygame.time.delay(1000)
        run = False
      #doing the same for other endings
      elif chance == 2:
        screen.blit(skeleton, [500, 188])
        screen.blit(pos3_diouloge, [100, 40])
        pygame.display.update()
        print("\nYou died :)")
        status.money = -1
        status.satisfaction = -1
        pygame.time.delay(10000)
        status.aliveCheck()
      #doing the same for other endings
      else:
        screen.blit(flightattendan_pic, [500, 188])
        screen.blit(pos4_diouloge, [100, 40])
        pygame.display.update()
        print("\nYou are alive...")
        pygame.time.delay(10000)
        run = False


#creating the class block and player for GetTheMoney game
class Block(pygame.sprite.Sprite):

  def __init__(self, color, width, height):
    super().__init__()
    self.width = width
    self.image = pygame.Surface([width, height])
    self.image.fill(WHITE)
    self.image.set_colorkey(WHITE)

    self.rect = self.image.get_rect()
    pygame.draw.circle(self.image, color,
                       [self.rect.x + width / 2, self.rect.y + height / 2],
                       width / 2)


class Player_Block(Block):
  #adding the update funciton so that the person can move
  def update(self):
    keys = pygame.key.get_pressed()
    if keys[pygame.K_a]:
      self.rect.x -= 5
    elif keys[pygame.K_d]:
      self.rect.x += 5
    elif keys[pygame.K_w]:
      self.rect.y -= 5
    elif keys[pygame.K_s]:
      self.rect.y += 5
    #making sure the person doesnt leave the screen
    if self.rect.x <= 0:
      self.rect.x = 0
    elif self.rect.x >= 710 - self.width:
      self.rect.x = 710 - self.width
    if self.rect.y <= 0:
      self.rect.y = 0
    elif self.rect.y >= 382 - self.width:
      self.rect.y = 382 - self.width


#making the first game
class GettheMoney():
  coinList = pygame.sprite.Group()
  fakeList = pygame.sprite.Group()
  allList = pygame.sprite.Group()

  def __init__(self):
    super().__init__()
    #making the blocks
    for _ in range(25):
      block = Block(Gold, 20, 20)
      block.rect.x = random.randrange(700)
      block.rect.y = random.randrange(372)
      GettheMoney.coinList.add(block)
      GettheMoney.allList.add(block)

      block = Block(BLACK, 20, 20)
      block.rect.x = random.randrange(700)
      block.rect.y = random.randrange(372)
      GettheMoney.fakeList.add(block)
      GettheMoney.allList.add(block)
    self.player = Player_Block(BLUE, 20, 20)
    self.player.rect.x = random.randrange(700)
    self.player.rect.y = random.randrange(372)
    GettheMoney.allList.add(self.player)
    self.score = 0
    self.balls_eaten = 0

  #creating the update function for the game so that each time they play it its differnet
  def update(self):
    global position
    GettheMoney.coinList.empty()
    GettheMoney.fakeList.empty()
    GettheMoney.allList.empty()
    for _ in range(25):
      block = Block(Gold, 20, 20)
      block.rect.x = random.randrange(700)
      block.rect.y = random.randrange(372)
      GettheMoney.coinList.add(block)
      GettheMoney.allList.add(block)

      block = Block(BLACK, 20, 20)
      block.rect.x = random.randrange(700)
      block.rect.y = random.randrange(372)
      GettheMoney.fakeList.add(block)
      GettheMoney.allList.add(block)
    self.player = Player_Block(BLUE, 20, 20)
    self.player.rect.x = random.randrange(700)
    self.player.rect.y = random.randrange(372)
    GettheMoney.allList.add(self.player)
    self.score = 0
    self.balls_eaten = 0
    GettheMoney.allList.draw(screen)
    print(
        "\nIn this game, you are a poor person and you want to get gold coins from the ground. Make sure you don't touch black coins!"
    )
    position += 1

  #making the play function
  def play(self):
    screen.fill(WHITE)
    GettheMoney.allList.draw(screen)
    self.player.update()
    #checking if the person has collided with the balls
    blockHitList = pygame.sprite.spritecollide(self.player,
                                               GettheMoney.coinList, True)
    fakehitlist = pygame.sprite.spritecollide(self.player,
                                              GettheMoney.fakeList, True)
    #printing the score
    for _ in blockHitList:
      self.score += 1
      self.balls_eaten += 1
      print("Score: ", self.score)
    for _ in fakehitlist:
      self.score -= 1
      self.balls_eaten += 1
      print("Score: ", self.score)
    #cahnging the money and satisfaction according to how the player played
    global position
    if self.score == 15:
      print("good job. You're Job is finished")
      status.money += random.randint(10, 30)
      status.satisfaction -= random.randint(5, 15)
      position += 1
    elif self.score == 10 and self.balls_eaten >= 40:
      position += 1
      status.money += random.randint(5, 20)
      status.satisfaction -= random.randint(5, 15)
    elif self.balls_eaten >= 45:
      position += 1
      status.satisfaction -= random.randint(10, 20)


#creating the second game
class Hangman():

  def __init__(self):
    #creating the fonts
    super().__init__()
    self.font1 = pygame.font.Font(None, 25)
    self.font2 = pygame.font.Font(None, 60)
    self.font3 = pygame.font.Font(None, 40)

  #crating the update function
  def update(self):
    global position
    position += 1

  #creating the play function
  def play(self):
    #clearing the screen
    screen.fill(WHITE)
    #making a list of lettersRemaining, lettersUsed and assigning guesses left
    alphabet = [
        'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n',
        'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'
    ]
    lettersUsed = []
    correctWord = []
    guessesLeft = random.randint(6, 10)
    #creating the total words list and the list of topics
    totalWords = [
        ["lion", "tiger", "dog", "cat", "bear", "fox", "wolf"],
        ["apple", "grapes", "kiwi", "mango", "pear", "peach", "plum"],
        [
            "cn-tower", "rom", "aquarium", "city-hall", "casa-loma",
            "high-park", "islands"
        ], ["red", "blue", "green", "yellow", "purple", "orange", "pink"],
        ["leafs", "raptors", "jays", "fc", "argos", "rock", "marlies"],
        ["canada", "usa", "japan", "germany", "brazil", "india", "france"],
        [
            "yorkville", "kensington", "annex", "leslieville", "queen-st",
            "high-park", "harborfront"
        ]
    ]
    #chossing the number, topic and word
    num = random.randint(0, 6)
    wordGroup = totalWords[num]
    topicList = [
        "Animals", "Fruits", "Toronto Landmarks", "Colors",
        "Toronto Sports Teams", "Countries", "Toronto Neighborhoods"
    ]
    topicText = self.font1.render(topicList[num], True, BLACK)
    word = wordGroup[random.randint(0, len(wordGroup) - 1)]
    #creating wordlist, secretWord string, and secret wordList
    wordList = []
    secretWord = ""
    secretWordList = []
    #creating variables to use later on in the game
    end = False
    happyEnd = False
    sadEnd = False
    #importang and edditing neccessary images
    redBallon_pic = pygame.image.load("red ballon.png").convert_alpha()
    redBallon_pic = pygame.transform.scale_by(redBallon_pic, 0.5)
    #edditing the wordList, secretWord and secreretWordList
    for item in word:
      wordList.append(item)
      if item == "-":
        secretWord += "- "
        secretWordList.append("- ")
      else:
        secretWord += "_ "
        secretWordList.append("_ ")
    #creating the transparent redsurface and greensurface
    redsurface = pygame.Surface((750, 600), pygame.SRCALPHA)
    redsurface.fill((255, 0, 0, 75))
    greensurface = pygame.Surface((750, 600), pygame.SRCALPHA)
    greensurface.fill((0, 255, 0, 75))
    #starting the game loop
    while guessesLeft >= 0:
      for event in pygame.event.get():
        if event.type == pygame.QUIT:
          global run
          run = False
      #getting mouse location
      mouseloc = pygame.mouse.get_pos()
      #drawing the neccessary elemnts on the screen
      screen.fill(WHITE)
      screen.blit(topicText, [(710 - 9 * len(topicList[num])) // 2, 20])
      text = self.font2.render(secretWord, True, BLACK)
      screen.blit(text, [(710 - 17 * len(secretWord)) // 2, 80])
      #drawing the ballons
      x = 0
      while x < guessesLeft:
        screen.blit(redBallon_pic, [350 + 20 * x, 250])
        x += 1
      #drawing the alphabet
      for item in alphabet:
        #assigning a color for each letter for better visuals
        if item in lettersUsed:
          color = GREY
        elif item in correctWord:
          color = GREEN
        else:
          color = BLACK
        #making the alphabet in three different lines lines
        if alphabet.index(item) < 9:
          startloc = 10 + 30 * alphabet.index(item)
          pygame.draw.rect(screen, color, [startloc, 200, 25, 25], 2)
          alphabetText = self.font1.render(item.upper(), True, color)
          screen.blit(alphabetText, [startloc + 5, 205])
          #checking if the person has pressed on an item
          if startloc < mouseloc[0] < startloc + 25 and 200 < mouseloc[
              1] < 225 and pygame.mouse.get_pressed()[0]:
            #checking if the item is in the word or not
            if item in wordList:
              correctWord.append(item)
              #updating the secretword
              for i in range(len(word)):
                if word[i] == item:
                  secretWordList[i] = item + " "
            #checking if the item has been used before or not
            elif item not in lettersUsed:
              lettersUsed.append(item)
              guessesLeft -= 1
        #doing the same for other three lines
        elif alphabet.index(item) < 18:
          startloc = 10 + 30 * (alphabet.index(item) - 9)
          pygame.draw.rect(screen, color, [startloc, 230, 25, 25], 2)
          alphabetText = self.font1.render(item.upper(), True, color)
          screen.blit(alphabetText, [startloc + 5, 235])
          if startloc < mouseloc[0] < startloc + 25 and 230 < mouseloc[
              1] < 255 and pygame.mouse.get_pressed()[0]:
            if item in wordList:
              correctWord.append(item)
              for i in range(len(word)):
                if word[i] == item:
                  secretWordList[i] = item + " "
            elif item not in lettersUsed:
              lettersUsed.append(item)
              guessesLeft -= 1
        #doing the same for other three lines
        else:
          startloc = 10 + 30 * (alphabet.index(item) - 18)
          pygame.draw.rect(screen, color, [startloc, 260, 25, 25], 2)
          alphabetText = self.font1.render(item.upper(), True, color)
          screen.blit(alphabetText, [startloc + 5, 265])
          if startloc < mouseloc[0] < startloc + 25 and 260 < mouseloc[
              1] < 285 and pygame.mouse.get_pressed()[0]:
            if item in wordList:
              correctWord.append(item)
              for i in range(len(word)):
                if word[i] == item:
                  secretWordList[i] = item + " "
            elif item not in lettersUsed:
              lettersUsed.append(item)
              guessesLeft -= 1
      pygame.display.update()
      #updating the secretword
      secretWord = "".join(secretWordList)
      #checking if the game has ended
      if end:
        break
      elif "".join(secretWordList).replace(" ", "") == word.replace(" ", ""):
        happyEnd = True
        end = True
      elif guessesLeft <= 0:
        sadEnd = True
        end = True
    #checking how the game ended and updating the screen accordingly
    if happyEnd:
      screen.blit(greensurface, (0, 0))
      text4 = self.font3.render(f"Congratulations {word.upper()} is correct!",
                                True, BLACK)
      screen.blit(text4, [(710 - 17 * (len(word) + 27)) // 2, 150])
      status.money += random.randint(40, 60)
      status.satisfaction -= random.randint(0, 8)
    elif sadEnd:
      screen.blit(redsurface, (0, 0))
      text4 = self.font3.render(
          f"GAME OVER! the secret word was {word.upper()}!", True, BLACK)
      screen.blit(text4, [(698 - 17 * (len(word) + 32)) // 2, 150])
      status.money += random.randint(0, 30)
      status.satisfaction -= random.randint(5, 15)
    pygame.display.update()
    #waiting for the user to read the message then changing the screen
    pygame.time.delay(5000)
    global position
    position += 1


position = 0
current_map_no = 0
finishedAmnt = 0
run = True
new_time = 0


def main():
  #creating the maps list for sprites
  mapList = []
  background0 = welcomePage(500)
  mapList.append(background0)
  background1 = TorontoBckground()
  mapList.append(background1)
  background2 = Wilowdale()
  mapList.append(background2)
  background3 = TorontoCenter()
  mapList.append(background3)
  background4 = EtobicokeNorth()
  mapList.append(background4)
  background5 = ScarbroughAgincourt()
  mapList.append(background5)
  background6 = YorkSouth_weston()
  mapList.append(background6)
  backgroundAirport = Airport()
  mapList.append(backgroundAirport)
  #creating the game list for the games
  gameList = []
  game1 = GettheMoney()
  gameList.append(game1)
  game2 = Hangman()
  gameList.append(game2)

  #creating neccessary variables for the game
  global position
  global current_map_no
  global finishedAmnt
  global run
  global new_time
  current_map = mapList[current_map_no]
  game_num = 0
  start = True
  welcomePage_bool = True
  clock = pygame.time.Clock()
  infoFont = pygame.font.Font(None, 20)

  while run:
    #checking if the person is still alive
    status.aliveCheck()
    #checking if the user wants to exit
    for event in pygame.event.get():
      if event.type == pygame.QUIT:
        run = False
    #getting loactions
    mouse_locx, mouse_locy = pygame.mouse.get_pos()
    #showing the current map
    mapList[current_map_no].show()

    #checking the position of the game
    if start:
      #if its start running the start page
      screen.blit(toronto_skyline, [0, 0])
      screen.blit(start_pic, [322, 155])
      #if the user pressed start, the program changes the map
      if 322 < mouse_locx < 388 and 178 < mouse_locy < 204 and pygame.mouse.get_pressed(
      )[0]:
        start = False
    #checking its the welcome page time
    elif welcomePage_bool:
      #moving the welcome page up
      current_map.y -= 2
      #checking if the welcome page has ended and changing the map
      if current_map.y < -550:
        current_map_no = 1
        welcomePage_bool = False
    #checking if its tornto background time
    elif current_map_no == 1:
      #updating the position to 0
      position = 0
      #checking if the user has pressed any of the neighbourhoods
      if CircleMouseCheck(
          12, [320 - 12, 60 - 12]) and pygame.mouse.get_pressed()[0]:
        #checking if the neighbourhood is still available
        if not mapList[2].finished:
          #if its available changing the map to that neighbourhood
          current_map_no = 2
          new_time = pygame.time.get_ticks() + 10000
        else:
          print("You already explored here!")
      #doing same for other neighbourhoods
      if CircleMouseCheck(12, [304, 264]) and pygame.mouse.get_pressed()[0]:
        if not mapList[3].finished:
          current_map_no = 3
          new_time = pygame.time.get_ticks() + 10000
        else:
          print("You already explored here!")
      #doing same for other neighbourhoods
      if CircleMouseCheck(
          12, [105 - 12, 272 - 12]) and pygame.mouse.get_pressed()[0]:
        if not mapList[4].finished:
          current_map_no = 4
          new_time = pygame.time.get_ticks() + 10000
        else:
          print("You already explored here!")
      #doing the same for other neighbourhoods
      if CircleMouseCheck(12, [448, 48]) and pygame.mouse.get_pressed()[0]:
        if not mapList[5].finished:
          current_map_no = 5
          new_time = pygame.time.get_ticks() + 10000
        else:
          print("You already explored here!")
      #doing the same for other neighbourhoods
      if CircleMouseCheck(12, [170, 163]) and pygame.mouse.get_pressed()[0]:
        if not mapList[6].finished:
          current_map_no = 6
          pygame.time.delay(10)
          new_time = pygame.time.get_ticks() + 10000
        else:
          print("You already explored here!")
    #checking if the map is one of the neighbourhoods
    elif current_map_no >= 2:
      #making sure the events happen in the right order
      if position == 0:
        mapList[current_map_no].knowledge()
        game_num = random.randint(0, 1)
      elif position == 1:
        gameList[game_num].update()
      elif position == 2:
        gameList[game_num].play()
      elif position == 3:
        mapList[current_map_no].souvenir()
    #cheking if its the ending time
    elif current_map_no == -1:
      mapList[current_map_no].knowledge()
      mapList[current_map_no].end()

    #checking if the person has explored all the neighbourhoods
    if finishedAmnt >= 5:
      screen.blit(airplaneIcon_pic, [20, 20])
      if CircleMouseCheck(25, [20, 20]) and pygame.mouse.get_pressed()[0]:
        current_map_no = -1
        new_time = pygame.time.get_ticks() + 10000
    #displaying the money and satisfaciton
    if not start and not welcomePage_bool:
      moneyText = infoFont.render("Money= " + str(status.money), True, RED)
      satisfactionText = infoFont.render(
          "Satisfaction= " + str(status.satisfaction), True, RED)
      screen.blit(moneyText, [585, 10])
      screen.blit(satisfactionText, [585, 25])
    #updaying the game and adding clock tick
    pygame.display.update()
    clock.tick(20)

  #letting the user know the program is ending
  print("\nProgram is going to end!")
  #waiting for the user to read anything thats on the screen and ending the program
  pygame.time.delay(1000)
  pygame.quit()


if __name__ == "__main__":
  main()
