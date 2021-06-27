.PHONY: clean domainname build production-build serve

clean:
	rm -rf public

domainname:
	cp CNAME ./public

build: clean
	hugo --gc --minify

production-build: build domainname

serve:
	hugo server -w