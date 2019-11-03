public/index.html: public/elm.js

public/elm.js: $(wildcard frontend/*.elm)
	elm make frontend/Main.elm --output=public/elm.js

.PHONY=clean
clean:
	rm public/elm.js
