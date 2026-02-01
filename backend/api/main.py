from fastapi import FastAPI

app = FastAPI()

from api.categories.category_routes import router as category_router

app.include_router(category_router, prefix="/categories")


from api.auth.auth_routes import router as auth_router

# Mount all auth endpoints under /auth
app.include_router(auth_router)


from api.reports.report_routes import router as report_router

app.include_router(report_router, prefix="/reports")
