APP_NAME   = icl
VERSION    = 0.1

CL         = sbcl
LISP_SRC   = $(wildcard src/*lisp) \
	     icl.asd

BUILDDIR   = build
LIBS       = $(BUILDDIR)/libs.stamp
QLDIR      = $(BUILDDIR)/quicklisp
MANIFEST   = $(BUILDDIR)/manifest.ql

BUILDAPP   = $(BUILDDIR)/bin/buildapp.sbcl
CL_OPTS    = --no-sysinit --no-userinit

BUILDAPP_OPTS = --require sb-posix      \
	--require sb-bsd-sockets        \
	--require sb-rotate-byte

ICL        = $(BUILDDIR)/bin/$(APP_NAME)

all: $(ICL)

clean:
	rm -rf $(LIBS) $(QLDIR) $(MANIFEST) $(BUILDAPP) $(ICL)

$(QLDIR)/setup.lisp:
	mkdir -p $(BUILDDIR)
	curl -o $(BUILDDIR)/quicklisp.lisp https://beta.quicklisp.org/quicklisp.lisp
	$(CL) $(CL_OPTS) --load $(BUILDDIR)/quicklisp.lisp                         \
	     --eval '(quicklisp-quickstart:install :path "$(BUILDDIR)/quicklisp")' \
	     --eval '(quit)'

quicklisp: $(QLDIR)/setup.lisp ;

$(LIBS): $(QLDIR)/setup.lisp
	$(CL) $(CL_OPTS) --load $(QLDIR)/setup.lisp               \
	     --eval '(push "$(PWD)/" asdf:*central-registry*)'    \
	     --eval '(ql:quickload "icl")'                        \
	     --eval '(quit)'
	touch $@

libs: $(LIBS) ;

$(MANIFEST): $(LIBS)
	$(CL) $(CL_OPTS) --load $(QLDIR)/setup.lisp               \
	     --eval '(ql:write-asdf-manifest-file "$(MANIFEST)")' \
	     --eval '(quit)'

manifest: $(MANIFEST) ;

$(BUILDAPP): $(QLDIR)/setup.lisp
	mkdir -p $(BUILDDIR)/bin
	$(CL) $(CL_OPTS) --load $(QLDIR)/setup.lisp               \
	     --eval '(ql:quickload "buildapp")'                   \
	     --eval '(buildapp:build-buildapp "$@")'              \
	     --eval '(quit)'

buildapp: $(BUILDAPP) ;


$(ICL): $(MANIFEST) $(BUILDAPP) $(LISP_SRC)
	mkdir -p $(BUILDDIR)/bin
	$(BUILDAPP) --logfile /tmp/build.log         \
	     $(BUILDAPP_OPTS)                        \
	     --sbcl $(CL)                            \
	     --asdf-path .                           \
	     --manifest-file $(MANIFEST)             \
	     --asdf-tree $(QLDIR)/dists              \
	     --asdf-path .                           \
	     --load-system $(APP_NAME)               \
	     --entry icl:main                        \
	     --output $@


icl: $(ICL) ;
