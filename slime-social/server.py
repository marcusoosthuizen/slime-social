from aiohttp import web
import socketio
from profanity import profanity
import time

sio = socketio.AsyncServer()
app = web.Application()

sio.attach(app)


async def index(request):
    with open('index.html') as f:
        return web.Response(text=f.read(), content_type='text/html')

user_list = []
user_count = 0
history = []

@sio.event
async def connect(sid, environ, auth):
    print(f"user (ID {sid}) connected")
    user_list.append([sid, "", 0])
    print(user_list)
    await sio.emit("list_update", user_count)
    await sio.emit("history", history, room=sid)
    

@sio.event
async def disconnect(sid):
    global user_count
    for user in user_list:
      if user[0] == sid:
        if user[1] != "":
          await sio.emit("chat_message", [user[1] + " has left the room"])
          history.append([user[1] + " has left the room"])
          user_count -= 1
          if len(history) > 21:
            history.pop(0)
        user_list.remove(user)
        break
    print(f"user (ID {sid}) disconnected")
    print(user_list)
    await sio.emit("list_update", user_count)

@sio.on('assign_username')
async def assign_username(sid, message):
    global user_count
    passcard = True

    for user in user_list:
      if user[1] == message:
        passcard = False
        await sio.emit("taken", room=sid)


    if passcard:
      for user in user_list:
        if user[0] == sid:
          user[1] = profanity.censor(message)
          user_count += 1
          await sio.emit("chat_message", [user[1] + " has joined the room"])
          history.append([user[1] + " has joined the room"])
          await sio.emit("accepted", room=sid)
          if len(history) > 21:
            history.pop(0)
          break
      print(f"user (ID {sid}) assigned username ({message})")
      await sio.emit("list_update", user_count)

@sio.on('submit_message')
async def submit_message(sid, message):
    for user in user_list:
      if user[0] == sid:
        if user[1] == "":
          await sio.emit("disconnect", room=sid)
        elif time.time() - user[2] < .75:
          await sio.emit("toofast", room=sid)
        else:
          await sio.emit("chat_message", ["<" + user[1] + ">", time.time(), profanity.censor(message)])
          user[2] = time.time()
          history.append(["<" + user[1] + ">", time.time(), profanity.censor(message)])
          if len(history) > 21:
            history.pop(0)
          print(f'user {user[1]} sent "{message}"')
          break




app.router.add_get('/', index)
app.router.add_static('/',
                          path="./",
                          name='root')

if __name__ == '__main__':
    web.run_app(app)


#await sio.emit("chat_message", ["<" + user[1] + ">", time.strftime('%I:%M %p', time.localtime()), profanity.censor(message)])
#history.append(["<" + user[1] + ">", time.strftime('%I:%M %p', time.localtime()), profanity.censor(message)])