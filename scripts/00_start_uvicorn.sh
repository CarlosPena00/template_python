if [ -f /.dockerenv ]; then
    uvicorn src.server:app --host 0.0.0.0 --reload #--workers 4
else
    uv run uvicorn src.server:app --host 0.0.0.0 --reload #--workers 4
fi
