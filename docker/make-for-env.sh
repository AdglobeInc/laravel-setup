
if [ ! -e .env ]; then
    cp .env.example .env
fi

if [ ! -e .env.testing ]; then
    cp .env.example .env.testing
    sed -i "" "s/APP_ENV=local/APP_ENV=testing/g" .env.testing
fi
