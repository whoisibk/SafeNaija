from fastapi import FastAPI
from api.auth.auth_routes import router as auth_router

app = FastAPI()

# Mount all auth endpoints under /auth
app.include_router(auth_router)

