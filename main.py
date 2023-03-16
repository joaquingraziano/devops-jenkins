#!/usr/bin/env python3
import time

mensaje = "¡Voy a enviar este mensaje cada 1 segundo. Si me cuelgo sera tu culpa 2!!"
while True:
    print(mensaje)
    time.sleep(1)