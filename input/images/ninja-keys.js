        /**
         * @license
         * Copyright 2019 Google LLC
         * SPDX-License-Identifier: BSD-3-Clause
         */
        const t =
            window.ShadowRoot &&
            (void 0 === window.ShadyCSS || window.ShadyCSS.nativeShadow) &&
            "adoptedStyleSheets" in Document.prototype &&
            "replace" in CSSStyleSheet.prototype,
          i = Symbol(),
          e = new Map();
        class n {
          constructor(t, e) {
            if (((this._$cssResult$ = !0), e !== i))
              throw Error(
                "CSSResult is not constructable. Use `unsafeCSS` or `css` instead."
              );
            this.cssText = t;
          }
          get styleSheet() {
            let i = e.get(this.cssText);
            return (
              t &&
                void 0 === i &&
                (e.set(this.cssText, (i = new CSSStyleSheet())),
                i.replaceSync(this.cssText)),
              i
            );
          }
          toString() {
            return this.cssText;
          }
        }
        const s = (t, ...e) => {
            const s =
              1 === t.length
                ? t[0]
                : e.reduce(
                    (i, e, n) =>
                      i +
                      ((t) => {
                        if (!0 === t._$cssResult$) return t.cssText;
                        if ("number" == typeof t) return t;
                        throw Error(
                          "Value passed to 'css' function must be a 'css' function result: " +
                            t +
                            ". Use 'unsafeCSS' to pass non-literal values, but take care to ensure page security."
                        );
                      })(e) +
                      t[n + 1],
                    t[0]
                  );
            return new n(s, i);
          },
          o = t
            ? (t) => t
            : (t) =>
                t instanceof CSSStyleSheet
                  ? ((t) => {
                      let e = "";
                      for (const i of t.cssRules) e += i.cssText;
                      return ((t) => new n("string" == typeof t ? t : t + "", i))(e);
                    })(t)
                  : t;
        /**
         * @license
         * Copyright 2017 Google LLC
         * SPDX-License-Identifier: BSD-3-Clause
         */ var r;
        const a = window.trustedTypes,
          l = a ? a.emptyScript : "",
          h = window.reactiveElementPolyfillSupport,
          c = {
            toAttribute(t, i) {
              switch (i) {
                case Boolean:
                  t = t ? l : null;
                  break;
                case Object:
                case Array:
                  t = null == t ? t : JSON.stringify(t);
              }
              return t;
            },
            fromAttribute(t, i) {
              let e = t;
              switch (i) {
                case Boolean:
                  e = null !== t;
                  break;
                case Number:
                  e = null === t ? null : Number(t);
                  break;
                case Object:
                case Array:
                  try {
                    e = JSON.parse(t);
                  } catch (t) {
                    e = null;
                  }
              }
              return e;
            },
          },
          d = (t, i) => i !== t && (i == i || t == t),
          u = { attribute: !0, type: String, converter: c, reflect: !1, hasChanged: d };
        class v extends HTMLElement {
          constructor() {
            super(),
              (this._$Et = new Map()),
              (this.isUpdatePending = !1),
              (this.hasUpdated = !1),
              (this._$Ei = null),
              this.o();
          }
          static addInitializer(t) {
            var i;
            (null !== (i = this.l) && void 0 !== i) || (this.l = []), this.l.push(t);
          }
          static get observedAttributes() {
            this.finalize();
            const t = [];
            return (
              this.elementProperties.forEach((i, e) => {
                const n = this._$Eh(e, i);
                void 0 !== n && (this._$Eu.set(n, e), t.push(n));
              }),
              t
            );
          }
          static createProperty(t, i = u) {
            if (
              (i.state && (i.attribute = !1),
              this.finalize(),
              this.elementProperties.set(t, i),
              !i.noAccessor && !this.prototype.hasOwnProperty(t))
            ) {
              const e = "symbol" == typeof t ? Symbol() : "__" + t,
                n = this.getPropertyDescriptor(t, e, i);
              void 0 !== n && Object.defineProperty(this.prototype, t, n);
            }
          }
          static getPropertyDescriptor(t, i, e) {
            return {
              get() {
                return this[i];
              },
              set(n) {
                const s = this[t];
                (this[i] = n), this.requestUpdate(t, s, e);
              },
              configurable: !0,
              enumerable: !0,
            };
          }
          static getPropertyOptions(t) {
            return this.elementProperties.get(t) || u;
          }
          static finalize() {
            if (this.hasOwnProperty("finalized")) return !1;
            this.finalized = !0;
            const t = Object.getPrototypeOf(this);
            if (
              (t.finalize(),
              (this.elementProperties = new Map(t.elementProperties)),
              (this._$Eu = new Map()),
              this.hasOwnProperty("properties"))
            ) {
              const t = this.properties,
                i = [
                  ...Object.getOwnPropertyNames(t),
                  ...Object.getOwnPropertySymbols(t),
                ];
              for (const e of i) this.createProperty(e, t[e]);
            }
            return (this.elementStyles = this.finalizeStyles(this.styles)), !0;
          }
          static finalizeStyles(t) {
            const i = [];
            if (Array.isArray(t)) {
              const e = new Set(t.flat(1 / 0).reverse());
              for (const t of e) i.unshift(o(t));
            } else void 0 !== t && i.push(o(t));
            return i;
          }
          static _$Eh(t, i) {
            const e = i.attribute;
            return !1 === e
              ? void 0
              : "string" == typeof e
              ? e
              : "string" == typeof t
              ? t.toLowerCase()
              : void 0;
          }
          o() {
            var t;
            (this._$Ep = new Promise((t) => (this.enableUpdating = t))),
              (this._$AL = new Map()),
              this._$Em(),
              this.requestUpdate(),
              null === (t = this.constructor.l) ||
                void 0 === t ||
                t.forEach((t) => t(this));
          }
          addController(t) {
            var i, e;
            (null !== (i = this._$Eg) && void 0 !== i ? i : (this._$Eg = [])).push(t),
              void 0 !== this.renderRoot &&
                this.isConnected &&
                (null === (e = t.hostConnected) || void 0 === e || e.call(t));
          }
          removeController(t) {
            var i;
            null === (i = this._$Eg) ||
              void 0 === i ||
              i.splice(this._$Eg.indexOf(t) >>> 0, 1);
          }
          _$Em() {
            this.constructor.elementProperties.forEach((t, i) => {
              this.hasOwnProperty(i) && (this._$Et.set(i, this[i]), delete this[i]);
            });
          }
          createRenderRoot() {
            var i;
            const e =
              null !== (i = this.shadowRoot) && void 0 !== i
                ? i
                : this.attachShadow(this.constructor.shadowRootOptions);
            return (
              ((i, e) => {
                t
                  ? (i.adoptedStyleSheets = e.map((t) =>
                      t instanceof CSSStyleSheet ? t : t.styleSheet
                    ))
                  : e.forEach((t) => {
                      const e = document.createElement("style"),
                        n = window.litNonce;
                      void 0 !== n && e.setAttribute("nonce", n),
                        (e.textContent = t.cssText),
                        i.appendChild(e);
                    });
              })(e, this.constructor.elementStyles),
              e
            );
          }
          connectedCallback() {
            var t;
            void 0 === this.renderRoot && (this.renderRoot = this.createRenderRoot()),
              this.enableUpdating(!0),
              null === (t = this._$Eg) ||
                void 0 === t ||
                t.forEach((t) => {
                  var i;
                  return null === (i = t.hostConnected) || void 0 === i
                    ? void 0
                    : i.call(t);
                });
          }
          enableUpdating(t) {}
          disconnectedCallback() {
            var t;
            null === (t = this._$Eg) ||
              void 0 === t ||
              t.forEach((t) => {
                var i;
                return null === (i = t.hostDisconnected) || void 0 === i
                  ? void 0
                  : i.call(t);
              });
          }
          attributeChangedCallback(t, i, e) {
            this._$AK(t, e);
          }
          _$ES(t, i, e = u) {
            var n, s;
            const o = this.constructor._$Eh(t, e);
            if (void 0 !== o && !0 === e.reflect) {
              const r = (
                null !==
                  (s =
                    null === (n = e.converter) || void 0 === n
                      ? void 0
                      : n.toAttribute) && void 0 !== s
                  ? s
                  : c.toAttribute
              )(i, e.type);
              (this._$Ei = t),
                null == r ? this.removeAttribute(o) : this.setAttribute(o, r),
                (this._$Ei = null);
            }
          }
          _$AK(t, i) {
            var e, n, s;
            const o = this.constructor,
              r = o._$Eu.get(t);
            if (void 0 !== r && this._$Ei !== r) {
              const t = o.getPropertyOptions(r),
                a = t.converter,
                l =
                  null !==
                    (s =
                      null !==
                        (n =
                          null === (e = a) || void 0 === e
                            ? void 0
                            : e.fromAttribute) && void 0 !== n
                        ? n
                        : "function" == typeof a
                        ? a
                        : null) && void 0 !== s
                    ? s
                    : c.fromAttribute;
              (this._$Ei = r), (this[r] = l(i, t.type)), (this._$Ei = null);
            }
          }
          requestUpdate(t, i, e) {
            let n = !0;
            void 0 !== t &&
              (((e = e || this.constructor.getPropertyOptions(t)).hasChanged || d)(
                this[t],
                i
              )
                ? (this._$AL.has(t) || this._$AL.set(t, i),
                  !0 === e.reflect &&
                    this._$Ei !== t &&
                    (void 0 === this._$EC && (this._$EC = new Map()),
                    this._$EC.set(t, e)))
                : (n = !1)),
              !this.isUpdatePending && n && (this._$Ep = this._$E_());
          }
          async _$E_() {
            this.isUpdatePending = !0;
            try {
              await this._$Ep;
            } catch (t) {
              Promise.reject(t);
            }
            const t = this.scheduleUpdate();
            return null != t && (await t), !this.isUpdatePending;
          }
          scheduleUpdate() {
            return this.performUpdate();
          }
          performUpdate() {
            var t;
            if (!this.isUpdatePending) return;
            this.hasUpdated,
              this._$Et &&
                (this._$Et.forEach((t, i) => (this[i] = t)), (this._$Et = void 0));
            let i = !1;
            const e = this._$AL;
            try {
              (i = this.shouldUpdate(e)),
                i
                  ? (this.willUpdate(e),
                    null === (t = this._$Eg) ||
                      void 0 === t ||
                      t.forEach((t) => {
                        var i;
                        return null === (i = t.hostUpdate) || void 0 === i
                          ? void 0
                          : i.call(t);
                      }),
                    this.update(e))
                  : this._$EU();
            } catch (t) {
              throw ((i = !1), this._$EU(), t);
            }
            i && this._$AE(e);
          }
          willUpdate(t) {}
          _$AE(t) {
            var i;
            null === (i = this._$Eg) ||
              void 0 === i ||
              i.forEach((t) => {
                var i;
                return null === (i = t.hostUpdated) || void 0 === i
                  ? void 0
                  : i.call(t);
              }),
              this.hasUpdated || ((this.hasUpdated = !0), this.firstUpdated(t)),
              this.updated(t);
          }
          _$EU() {
            (this._$AL = new Map()), (this.isUpdatePending = !1);
          }
          get updateComplete() {
            return this.getUpdateComplete();
          }
          getUpdateComplete() {
            return this._$Ep;
          }
          shouldUpdate(t) {
            return !0;
          }
          update(t) {
            void 0 !== this._$EC &&
              (this._$EC.forEach((t, i) => this._$ES(i, this[i], t)),
              (this._$EC = void 0)),
              this._$EU();
          }
          updated(t) {}
          firstUpdated(t) {}
        }
        /**
         * @license
         * Copyright 2017 Google LLC
         * SPDX-License-Identifier: BSD-3-Clause
         */
        var f;
        (v.finalized = !0),
          (v.elementProperties = new Map()),
          (v.elementStyles = []),
          (v.shadowRootOptions = { mode: "open" }),
          null == h || h({ ReactiveElement: v }),
          (null !== (r = globalThis.reactiveElementVersions) && void 0 !== r
            ? r
            : (globalThis.reactiveElementVersions = [])
          ).push("1.3.2");
        const p = globalThis.trustedTypes,
          m = p ? p.createPolicy("lit-html", { createHTML: (t) => t }) : void 0,
          b = `lit$${(Math.random() + "").slice(9)}$`,
          g = "?" + b,
          y = `<${g}>`,
          w = document,
          j = (t = "") => w.createComment(t),
          k = (t) => null === t || ("object" != typeof t && "function" != typeof t),
          x = Array.isArray,
          $ = (t) => {
            var i;
            return (
              x(t) ||
              "function" ==
                typeof (null === (i = t) || void 0 === i ? void 0 : i[Symbol.iterator])
            );
          },
          _ = /<(?:(!--|\/[^a-zA-Z])|(\/?[a-zA-Z][^>\s]*)|(\/?$))/g,
          S = /-->/g,
          z = />/g,
          A =
            />|[ 	\n\r](?:([^\s"'>=/]+)([ 	\n\r]*=[ 	\n\r]*(?:[^ 	\n\r"'`<>=]|("|')|))|$)/g,
          C = /'/g,
          E = /"/g,
          M = /^(?:script|style|textarea|title)$/i,
          T = (
            (t) =>
            (i, ...e) => ({ _$litType$: t, strings: i, values: e })
          )(1),
          O = Symbol.for("lit-noChange"),
          H = Symbol.for("lit-nothing"),
          K = new WeakMap(),
          B = w.createTreeWalker(w, 129, null, !1),
          U = (t, i) => {
            const e = t.length - 1,
              n = [];
            let s,
              o = 2 === i ? "<svg>" : "",
              r = _;
            for (let i = 0; i < e; i++) {
              const e = t[i];
              let a,
                l,
                h = -1,
                c = 0;
              for (; c < e.length && ((r.lastIndex = c), (l = r.exec(e)), null !== l); )
                (c = r.lastIndex),
                  r === _
                    ? "!--" === l[1]
                      ? (r = S)
                      : void 0 !== l[1]
                      ? (r = z)
                      : void 0 !== l[2]
                      ? (M.test(l[2]) && (s = RegExp("</" + l[2], "g")), (r = A))
                      : void 0 !== l[3] && (r = A)
                    : r === A
                    ? ">" === l[0]
                      ? ((r = null != s ? s : _), (h = -1))
                      : void 0 === l[1]
                      ? (h = -2)
                      : ((h = r.lastIndex - l[2].length),
                        (a = l[1]),
                        (r = void 0 === l[3] ? A : '"' === l[3] ? E : C))
                    : r === E || r === C
                    ? (r = A)
                    : r === S || r === z
                    ? (r = _)
                    : ((r = A), (s = void 0));
              const d = r === A && t[i + 1].startsWith("/>") ? " " : "";
              o +=
                r === _
                  ? e + y
                  : h >= 0
                  ? (n.push(a), e.slice(0, h) + "$lit$" + e.slice(h) + b + d)
                  : e + b + (-2 === h ? (n.push(void 0), i) : d);
            }
            const a = o + (t[e] || "<?>") + (2 === i ? "</svg>" : "");
            if (!Array.isArray(t) || !t.hasOwnProperty("raw"))
              throw Error("invalid template strings array");
            return [void 0 !== m ? m.createHTML(a) : a, n];
          };
        class L {
          constructor({ strings: t, _$litType$: i }, e) {
            let n;
            this.parts = [];
            let s = 0,
              o = 0;
            const r = t.length - 1,
              a = this.parts,
              [l, h] = U(t, i);
            if (
              ((this.el = L.createElement(l, e)),
              (B.currentNode = this.el.content),
              2 === i)
            ) {
              const t = this.el.content,
                i = t.firstChild;
              i.remove(), t.append(...i.childNodes);
            }
            for (; null !== (n = B.nextNode()) && a.length < r; ) {
              if (1 === n.nodeType) {
                if (n.hasAttributes()) {
                  const t = [];
                  for (const i of n.getAttributeNames())
                    if (i.endsWith("$lit$") || i.startsWith(b)) {
                      const e = h[o++];
                      if ((t.push(i), void 0 !== e)) {
                        const t = n.getAttribute(e.toLowerCase() + "$lit$").split(b),
                          i = /([.?@])?(.*)/.exec(e);
                        a.push({
                          type: 1,
                          index: s,
                          name: i[2],
                          strings: t,
                          ctor:
                            "." === i[1] ? N : "?" === i[1] ? J : "@" === i[1] ? F : V,
                        });
                      } else a.push({ type: 6, index: s });
                    }
                  for (const i of t) n.removeAttribute(i);
                }
                if (M.test(n.tagName)) {
                  const t = n.textContent.split(b),
                    i = t.length - 1;
                  if (i > 0) {
                    n.textContent = p ? p.emptyScript : "";
                    for (let e = 0; e < i; e++)
                      n.append(t[e], j()),
                        B.nextNode(),
                        a.push({ type: 2, index: ++s });
                    n.append(t[i], j());
                  }
                }
              } else if (8 === n.nodeType)
                if (n.data === g) a.push({ type: 2, index: s });
                else {
                  let t = -1;
                  for (; -1 !== (t = n.data.indexOf(b, t + 1)); )
                    a.push({ type: 7, index: s }), (t += b.length - 1);
                }
              s++;
            }
          }
          static createElement(t, i) {
            const e = w.createElement("template");
            return (e.innerHTML = t), e;
          }
        }
        function I(t, i, e = t, n) {
          var s, o, r, a;
          if (i === O) return i;
          let l =
            void 0 !== n
              ? null === (s = e._$Cl) || void 0 === s
                ? void 0
                : s[n]
              : e._$Cu;
          const h = k(i) ? void 0 : i._$litDirective$;
          return (
            (null == l ? void 0 : l.constructor) !== h &&
              (null === (o = null == l ? void 0 : l._$AO) ||
                void 0 === o ||
                o.call(l, !1),
              void 0 === h ? (l = void 0) : ((l = new h(t)), l._$AT(t, e, n)),
              void 0 !== n
                ? ((null !== (r = (a = e)._$Cl) && void 0 !== r ? r : (a._$Cl = []))[
                    n
                  ] = l)
                : (e._$Cu = l)),
            void 0 !== l && (i = I(t, l._$AS(t, i.values), l, n)),
            i
          );
        }
        class P {
          constructor(t, i) {
            (this.v = []), (this._$AN = void 0), (this._$AD = t), (this._$AM = i);
          }
          get parentNode() {
            return this._$AM.parentNode;
          }
          get _$AU() {
            return this._$AM._$AU;
          }
          p(t) {
            var i;
            const {
                el: { content: e },
                parts: n,
              } = this._$AD,
              s = (
                null !== (i = null == t ? void 0 : t.creationScope) && void 0 !== i
                  ? i
                  : w
              ).importNode(e, !0);
            B.currentNode = s;
            let o = B.nextNode(),
              r = 0,
              a = 0,
              l = n[0];
            for (; void 0 !== l; ) {
              if (r === l.index) {
                let i;
                2 === l.type
                  ? (i = new R(o, o.nextSibling, this, t))
                  : 1 === l.type
                  ? (i = new l.ctor(o, l.name, l.strings, this, t))
                  : 6 === l.type && (i = new W(o, this, t)),
                  this.v.push(i),
                  (l = n[++a]);
              }
              r !== (null == l ? void 0 : l.index) && ((o = B.nextNode()), r++);
            }
            return s;
          }
          m(t) {
            let i = 0;
            for (const e of this.v)
              void 0 !== e &&
                (void 0 !== e.strings
                  ? (e._$AI(t, e, i), (i += e.strings.length - 2))
                  : e._$AI(t[i])),
                i++;
          }
        }
        class R {
          constructor(t, i, e, n) {
            var s;
            (this.type = 2),
              (this._$AH = H),
              (this._$AN = void 0),
              (this._$AA = t),
              (this._$AB = i),
              (this._$AM = e),
              (this.options = n),
              (this._$Cg =
                null === (s = null == n ? void 0 : n.isConnected) || void 0 === s || s);
          }
          get _$AU() {
            var t, i;
            return null !==
              (i = null === (t = this._$AM) || void 0 === t ? void 0 : t._$AU) &&
              void 0 !== i
              ? i
              : this._$Cg;
          }
          get parentNode() {
            let t = this._$AA.parentNode;
            const i = this._$AM;
            return void 0 !== i && 11 === t.nodeType && (t = i.parentNode), t;
          }
          get startNode() {
            return this._$AA;
          }
          get endNode() {
            return this._$AB;
          }
          _$AI(t, i = this) {
            (t = I(this, t, i)),
              k(t)
                ? t === H || null == t || "" === t
                  ? (this._$AH !== H && this._$AR(), (this._$AH = H))
                  : t !== this._$AH && t !== O && this.$(t)
                : void 0 !== t._$litType$
                ? this.T(t)
                : void 0 !== t.nodeType
                ? this.k(t)
                : $(t)
                ? this.S(t)
                : this.$(t);
          }
          M(t, i = this._$AB) {
            return this._$AA.parentNode.insertBefore(t, i);
          }
          k(t) {
            this._$AH !== t && (this._$AR(), (this._$AH = this.M(t)));
          }
          $(t) {
            this._$AH !== H && k(this._$AH)
              ? (this._$AA.nextSibling.data = t)
              : this.k(w.createTextNode(t)),
              (this._$AH = t);
          }
          T(t) {
            var i;
            const { values: e, _$litType$: n } = t,
              s =
                "number" == typeof n
                  ? this._$AC(t)
                  : (void 0 === n.el && (n.el = L.createElement(n.h, this.options)), n);
            if ((null === (i = this._$AH) || void 0 === i ? void 0 : i._$AD) === s)
              this._$AH.m(e);
            else {
              const t = new P(s, this),
                i = t.p(this.options);
              t.m(e), this.k(i), (this._$AH = t);
            }
          }
          _$AC(t) {
            let i = K.get(t.strings);
            return void 0 === i && K.set(t.strings, (i = new L(t))), i;
          }
          S(t) {
            x(this._$AH) || ((this._$AH = []), this._$AR());
            const i = this._$AH;
            let e,
              n = 0;
            for (const s of t)
              n === i.length
                ? i.push((e = new R(this.M(j()), this.M(j()), this, this.options)))
                : (e = i[n]),
                e._$AI(s),
                n++;
            n < i.length && (this._$AR(e && e._$AB.nextSibling, n), (i.length = n));
          }
          _$AR(t = this._$AA.nextSibling, i) {
            var e;
            for (
              null === (e = this._$AP) || void 0 === e || e.call(this, !1, !0, i);
              t && t !== this._$AB;

            ) {
              const i = t.nextSibling;
              t.remove(), (t = i);
            }
          }
          setConnected(t) {
            var i;
            void 0 === this._$AM &&
              ((this._$Cg = t),
              null === (i = this._$AP) || void 0 === i || i.call(this, t));
          }
        }
        class V {
          constructor(t, i, e, n, s) {
            (this.type = 1),
              (this._$AH = H),
              (this._$AN = void 0),
              (this.element = t),
              (this.name = i),
              (this._$AM = n),
              (this.options = s),
              e.length > 2 || "" !== e[0] || "" !== e[1]
                ? ((this._$AH = Array(e.length - 1).fill(new String())),
                  (this.strings = e))
                : (this._$AH = H);
          }
          get tagName() {
            return this.element.tagName;
          }
          get _$AU() {
            return this._$AM._$AU;
          }
          _$AI(t, i = this, e, n) {
            const s = this.strings;
            let o = !1;
            if (void 0 === s)
              (t = I(this, t, i, 0)),
                (o = !k(t) || (t !== this._$AH && t !== O)),
                o && (this._$AH = t);
            else {
              const n = t;
              let r, a;
              for (t = s[0], r = 0; r < s.length - 1; r++)
                (a = I(this, n[e + r], i, r)),
                  a === O && (a = this._$AH[r]),
                  o || (o = !k(a) || a !== this._$AH[r]),
                  a === H ? (t = H) : t !== H && (t += (null != a ? a : "") + s[r + 1]),
                  (this._$AH[r] = a);
            }
            o && !n && this.C(t);
          }
          C(t) {
            t === H
              ? this.element.removeAttribute(this.name)
              : this.element.setAttribute(this.name, null != t ? t : "");
          }
        }
        class N extends V {
          constructor() {
            super(...arguments), (this.type = 3);
          }
          C(t) {
            this.element[this.name] = t === H ? void 0 : t;
          }
        }
        const D = p ? p.emptyScript : "";
        class J extends V {
          constructor() {
            super(...arguments), (this.type = 4);
          }
          C(t) {
            t && t !== H
              ? this.element.setAttribute(this.name, D)
              : this.element.removeAttribute(this.name);
          }
        }
        class F extends V {
          constructor(t, i, e, n, s) {
            super(t, i, e, n, s), (this.type = 5);
          }
          _$AI(t, i = this) {
            var e;
            if ((t = null !== (e = I(this, t, i, 0)) && void 0 !== e ? e : H) === O)
              return;
            const n = this._$AH,
              s =
                (t === H && n !== H) ||
                t.capture !== n.capture ||
                t.once !== n.once ||
                t.passive !== n.passive,
              o = t !== H && (n === H || s);
            s && this.element.removeEventListener(this.name, this, n),
              o && this.element.addEventListener(this.name, this, t),
              (this._$AH = t);
          }
          handleEvent(t) {
            var i, e;
            "function" == typeof this._$AH
              ? this._$AH.call(
                  null !==
                    (e =
                      null === (i = this.options) || void 0 === i ? void 0 : i.host) &&
                    void 0 !== e
                    ? e
                    : this.element,
                  t
                )
              : this._$AH.handleEvent(t);
          }
        }
        class W {
          constructor(t, i, e) {
            (this.element = t),
              (this.type = 6),
              (this._$AN = void 0),
              (this._$AM = i),
              (this.options = e);
          }
          get _$AU() {
            return this._$AM._$AU;
          }
          _$AI(t) {
            I(this, t);
          }
        }
        const q = {
            L: "$lit$",
            P: b,
            V: g,
            I: 1,
            N: U,
            R: P,
            j: $,
            D: I,
            H: R,
            F: V,
            O: J,
            W: F,
            B: N,
            Z: W,
          },
          Z = window.litHtmlPolyfillSupport;
        /**
         * @license
         * Copyright 2017 Google LLC
         * SPDX-License-Identifier: BSD-3-Clause
         */
        var G, X;
        null == Z || Z(L, R),
          (null !== (f = globalThis.litHtmlVersions) && void 0 !== f
            ? f
            : (globalThis.litHtmlVersions = [])
          ).push("2.2.6");
        class Q extends v {
          constructor() {
            super(...arguments),
              (this.renderOptions = { host: this }),
              (this._$Dt = void 0);
          }
          createRenderRoot() {
            var t, i;
            const e = super.createRenderRoot();
            return (
              (null !== (t = (i = this.renderOptions).renderBefore) && void 0 !== t) ||
                (i.renderBefore = e.firstChild),
              e
            );
          }
          update(t) {
            const i = this.render();
            this.hasUpdated || (this.renderOptions.isConnected = this.isConnected),
              super.update(t),
              (this._$Dt = ((t, i, e) => {
                var n, s;
                const o =
                  null !== (n = null == e ? void 0 : e.renderBefore) && void 0 !== n
                    ? n
                    : i;
                let r = o._$litPart$;
                if (void 0 === r) {
                  const t =
                    null !== (s = null == e ? void 0 : e.renderBefore) && void 0 !== s
                      ? s
                      : null;
                  o._$litPart$ = r = new R(
                    i.insertBefore(j(), t),
                    t,
                    void 0,
                    null != e ? e : {}
                  );
                }
                return r._$AI(t), r;
              })(i, this.renderRoot, this.renderOptions));
          }
          connectedCallback() {
            var t;
            super.connectedCallback(),
              null === (t = this._$Dt) || void 0 === t || t.setConnected(!0);
          }
          disconnectedCallback() {
            var t;
            super.disconnectedCallback(),
              null === (t = this._$Dt) || void 0 === t || t.setConnected(!1);
          }
          render() {
            return O;
          }
        }
        (Q.finalized = !0),
          (Q._$litElement$ = !0),
          null === (G = globalThis.litElementHydrateSupport) ||
            void 0 === G ||
            G.call(globalThis, { LitElement: Q });
        const Y = globalThis.litElementPolyfillSupport;
        null == Y || Y({ LitElement: Q }),
          (null !== (X = globalThis.litElementVersions) && void 0 !== X
            ? X
            : (globalThis.litElementVersions = [])
          ).push("3.2.0");
        /**
         * @license
         * Copyright 2017 Google LLC
         * SPDX-License-Identifier: BSD-3-Clause
         */
        const tt = (t) => (i) =>
            "function" == typeof i
              ? ((t, i) => (window.customElements.define(t, i), i))(t, i)
              : ((t, i) => {
                  const { kind: e, elements: n } = i;
                  return {
                    kind: e,
                    elements: n,
                    finisher(i) {
                      window.customElements.define(t, i);
                    },
                  };
                })(t, i),
          /**
           * @license
           * Copyright 2017 Google LLC
           * SPDX-License-Identifier: BSD-3-Clause
           */ it = (t, i) =>
            "method" === i.kind && i.descriptor && !("value" in i.descriptor)
              ? {
                  ...i,
                  finisher(e) {
                    e.createProperty(i.key, t);
                  },
                }
              : {
                  kind: "field",
                  key: Symbol(),
                  placement: "own",
                  descriptor: {},
                  originalKey: i.key,
                  initializer() {
                    "function" == typeof i.initializer &&
                      (this[i.key] = i.initializer.call(this));
                  },
                  finisher(e) {
                    e.createProperty(i.key, t);
                  },
                };
        function et(t) {
          return (i, e) =>
            void 0 !== e
              ? ((t, i, e) => {
                  i.constructor.createProperty(e, t);
                })(t, i, e)
              : it(t, i);
          /**
           * @license
           * Copyright 2017 Google LLC
           * SPDX-License-Identifier: BSD-3-Clause
           */
        }
        function nt(t) {
          return et({ ...t, state: !0 });
        }
        /**
         * @license
         * Copyright 2021 Google LLC
         * SPDX-License-Identifier: BSD-3-Clause
         */ var st;
        null === (st = window.HTMLSlotElement) ||
          void 0 === st ||
          st.prototype.assignedElements;
        /**
         * @license
         * Copyright 2017 Google LLC
         * SPDX-License-Identifier: BSD-3-Clause
         */
        const ot = 1,
          rt = 2,
          at = 3,
          lt = 4,
          ht =
            (t) =>
            (...i) => ({ _$litDirective$: t, values: i });
        class ct {
          constructor(t) {}
          get _$AU() {
            return this._$AM._$AU;
          }
          _$AT(t, i, e) {
            (this._$Ct = t), (this._$AM = i), (this._$Ci = e);
          }
          _$AS(t, i) {
            return this.update(t, i);
          }
          update(t, i) {
            return this.render(...i);
          }
        }
        /**
         * @license
         * Copyright 2020 Google LLC
         * SPDX-License-Identifier: BSD-3-Clause
         */ const { H: dt } = q,
          ut = (t) => void 0 === t.strings,
          vt = () => document.createComment(""),
          ft = (t, i, e) => {
            var n;
            const s = t._$AA.parentNode,
              o = void 0 === i ? t._$AB : i._$AA;
            if (void 0 === e) {
              const i = s.insertBefore(vt(), o),
                n = s.insertBefore(vt(), o);
              e = new dt(i, n, t, t.options);
            } else {
              const i = e._$AB.nextSibling,
                r = e._$AM,
                a = r !== t;
              if (a) {
                let i;
                null === (n = e._$AQ) || void 0 === n || n.call(e, t),
                  (e._$AM = t),
                  void 0 !== e._$AP && (i = t._$AU) !== r._$AU && e._$AP(i);
              }
              if (i !== o || a) {
                let t = e._$AA;
                for (; t !== i; ) {
                  const i = t.nextSibling;
                  s.insertBefore(t, o), (t = i);
                }
              }
            }
            return e;
          },
          pt = (t, i, e = t) => (t._$AI(i, e), t),
          mt = {},
          bt = (t, i = mt) => (t._$AH = i),
          gt = (t) => {
            var i;
            null === (i = t._$AP) || void 0 === i || i.call(t, !1, !0);
            let e = t._$AA;
            const n = t._$AB.nextSibling;
            for (; e !== n; ) {
              const t = e.nextSibling;
              e.remove(), (e = t);
            }
          },
          yt = (t, i, e) => {
            const n = new Map();
            for (let s = i; s <= e; s++) n.set(t[s], s);
            return n;
          },
          wt = ht(
            class extends ct {
              constructor(t) {
                if ((super(t), t.type !== rt))
                  throw Error("repeat() can only be used in text expressions");
              }
              dt(t, i, e) {
                let n;
                void 0 === e ? (e = i) : void 0 !== i && (n = i);
                const s = [],
                  o = [];
                let r = 0;
                for (const i of t) (s[r] = n ? n(i, r) : r), (o[r] = e(i, r)), r++;
                return { values: o, keys: s };
              }
              render(t, i, e) {
                return this.dt(t, i, e).values;
              }
              update(t, [i, e, n]) {
                var s;
                const o = ((t) => t._$AH)(t),
                  { values: r, keys: a } = this.dt(i, e, n);
                if (!Array.isArray(o)) return (this.ut = a), r;
                const l = null !== (s = this.ut) && void 0 !== s ? s : (this.ut = []),
                  h = [];
                let c,
                  d,
                  u = 0,
                  v = o.length - 1,
                  f = 0,
                  p = r.length - 1;
                for (; u <= v && f <= p; )
                  if (null === o[u]) u++;
                  else if (null === o[v]) v--;
                  else if (l[u] === a[f]) (h[f] = pt(o[u], r[f])), u++, f++;
                  else if (l[v] === a[p]) (h[p] = pt(o[v], r[p])), v--, p--;
                  else if (l[u] === a[p])
                    (h[p] = pt(o[u], r[p])), ft(t, h[p + 1], o[u]), u++, p--;
                  else if (l[v] === a[f])
                    (h[f] = pt(o[v], r[f])), ft(t, o[u], o[v]), v--, f++;
                  else if (
                    (void 0 === c && ((c = yt(a, f, p)), (d = yt(l, u, v))),
                    c.has(l[u]))
                  )
                    if (c.has(l[v])) {
                      const i = d.get(a[f]),
                        e = void 0 !== i ? o[i] : null;
                      if (null === e) {
                        const i = ft(t, o[u]);
                        pt(i, r[f]), (h[f] = i);
                      } else (h[f] = pt(e, r[f])), ft(t, o[u], e), (o[i] = null);
                      f++;
                    } else gt(o[v]), v--;
                  else gt(o[u]), u++;
                for (; f <= p; ) {
                  const i = ft(t, h[p + 1]);
                  pt(i, r[f]), (h[f++] = i);
                }
                for (; u <= v; ) {
                  const t = o[u++];
                  null !== t && gt(t);
                }
                return (this.ut = a), bt(t, h), O;
              }
            }
          ),
          jt = ht(
            class extends ct {
              constructor(t) {
                if ((super(t), t.type !== at && t.type !== ot && t.type !== lt))
                  throw Error(
                    "The `live` directive is not allowed on child or event bindings"
                  );
                if (!ut(t))
                  throw Error("`live` bindings can only contain a single expression");
              }
              render(t) {
                return t;
              }
              update(t, [i]) {
                if (i === O || i === H) return i;
                const e = t.element,
                  n = t.name;
                if (t.type === at) {
                  if (i === e[n]) return O;
                } else if (t.type === lt) {
                  if (!!i === e.hasAttribute(n)) return O;
                } else if (t.type === ot && e.getAttribute(n) === i + "") return O;
                return bt(t), i;
              }
            }
          ),
          kt = (t, i) => {
            var e, n;
            const s = t._$AN;
            if (void 0 === s) return !1;
            for (const t of s)
              null === (n = (e = t)._$AO) || void 0 === n || n.call(e, i, !1), kt(t, i);
            return !0;
          },
          xt = (t) => {
            let i, e;
            do {
              if (void 0 === (i = t._$AM)) break;
              (e = i._$AN), e.delete(t), (t = i);
            } while (0 === (null == e ? void 0 : e.size));
          },
          $t = (t) => {
            for (let i; (i = t._$AM); t = i) {
              let e = i._$AN;
              if (void 0 === e) i._$AN = e = new Set();
              else if (e.has(t)) break;
              e.add(t), zt(i);
            }
          };
        /**
         * @license
         * Copyright 2017 Google LLC
         * SPDX-License-Identifier: BSD-3-Clause
         */ function _t(t) {
          void 0 !== this._$AN
            ? (xt(this), (this._$AM = t), $t(this))
            : (this._$AM = t);
        }
        function St(t, i = !1, e = 0) {
          const n = this._$AH,
            s = this._$AN;
          if (void 0 !== s && 0 !== s.size)
            if (i)
              if (Array.isArray(n))
                for (let t = e; t < n.length; t++) kt(n[t], !1), xt(n[t]);
              else null != n && (kt(n, !1), xt(n));
            else kt(this, t);
        }
        const zt = (t) => {
          var i, e, n, s;
          t.type == rt &&
            ((null !== (i = (n = t)._$AP) && void 0 !== i) || (n._$AP = St),
            (null !== (e = (s = t)._$AQ) && void 0 !== e) || (s._$AQ = _t));
        };
        class At extends ct {
          constructor() {
            super(...arguments), (this._$AN = void 0);
          }
          _$AT(t, i, e) {
            super._$AT(t, i, e), $t(this), (this.isConnected = t._$AU);
          }
          _$AO(t, i = !0) {
            var e, n;
            t !== this.isConnected &&
              ((this.isConnected = t),
              t
                ? null === (e = this.reconnected) || void 0 === e || e.call(this)
                : null === (n = this.disconnected) || void 0 === n || n.call(this)),
              i && (kt(this, t), xt(this));
          }
          setValue(t) {
            if (ut(this._$Ct)) this._$Ct._$AI(t, this);
            else {
              const i = [...this._$Ct._$AH];
              (i[this._$Ci] = t), this._$Ct._$AI(i, this, 0);
            }
          }
          disconnected() {}
          reconnected() {}
        }
        /**
         * @license
         * Copyright 2020 Google LLC
         * SPDX-License-Identifier: BSD-3-Clause
         */ const Ct = () => new Et();
        class Et {}
        const Mt = new WeakMap(),
          Tt = ht(
            class extends At {
              render(t) {
                return H;
              }
              update(t, [i]) {
                var e;
                const n = i !== this.U;
                return (
                  n && void 0 !== this.U && this.ot(void 0),
                  (n || this.rt !== this.lt) &&
                    ((this.U = i),
                    (this.ht =
                      null === (e = t.options) || void 0 === e ? void 0 : e.host),
                    this.ot((this.lt = t.element))),
                  H
                );
              }
              ot(t) {
                var i;
                if ("function" == typeof this.U) {
                  const e = null !== (i = this.ht) && void 0 !== i ? i : globalThis;
                  let n = Mt.get(e);
                  void 0 === n && ((n = new WeakMap()), Mt.set(e, n)),
                    void 0 !== n.get(this.U) && this.U.call(this.ht, void 0),
                    n.set(this.U, t),
                    void 0 !== t && this.U.call(this.ht, t);
                } else this.U.value = t;
              }
              get rt() {
                var t, i, e;
                return "function" == typeof this.U
                  ? null ===
                      (i = Mt.get(
                        null !== (t = this.ht) && void 0 !== t ? t : globalThis
                      )) || void 0 === i
                    ? void 0
                    : i.get(this.U)
                  : null === (e = this.U) || void 0 === e
                  ? void 0
                  : e.value;
              }
              disconnected() {
                this.rt === this.lt && this.ot(void 0);
              }
              reconnected() {
                this.ot(this.lt);
              }
            }
          ),
          Ot = ht(
            class extends ct {
              constructor(t) {
                var i;
                if (
                  (super(t),
                  t.type !== ot ||
                    "class" !== t.name ||
                    (null === (i = t.strings) || void 0 === i ? void 0 : i.length) > 2)
                )
                  throw Error(
                    "`classMap()` can only be used in the `class` attribute and must be the only part in the attribute."
                  );
              }
              render(t) {
                return (
                  " " +
                  Object.keys(t)
                    .filter((i) => t[i])
                    .join(" ") +
                  " "
                );
              }
              update(t, [i]) {
                var e, n;
                if (void 0 === this.et) {
                  (this.et = new Set()),
                    void 0 !== t.strings &&
                      (this.st = new Set(
                        t.strings
                          .join(" ")
                          .split(/\s/)
                          .filter((t) => "" !== t)
                      ));
                  for (const t in i)
                    i[t] &&
                      !(null === (e = this.st) || void 0 === e ? void 0 : e.has(t)) &&
                      this.et.add(t);
                  return this.render(i);
                }
                const s = t.element.classList;
                this.et.forEach((t) => {
                  t in i || (s.remove(t), this.et.delete(t));
                });
                for (const t in i) {
                  const e = !!i[t];
                  e === this.et.has(t) ||
                    (null === (n = this.st) || void 0 === n ? void 0 : n.has(t)) ||
                    (e ? (s.add(t), this.et.add(t)) : (s.remove(t), this.et.delete(t)));
                }
                return O;
              }
            }
          );
        /**
         * @license
         * Copyright 2018 Google LLC
         * SPDX-License-Identifier: BSD-3-Clause
         */
        /*!
         * hotkeys-js v3.8.7
         * A simple micro-library for defining and dispatching keyboard shortcuts. It has no dependencies.
         *
         * Copyright (c) 2021 kenny wong <wowohoo@qq.com>
         * http://jaywcjlove.github.io/hotkeys
         *
         * Licensed under the MIT license.
         */
        var Ht =
          "undefined" != typeof navigator &&
          navigator.userAgent.toLowerCase().indexOf("firefox") > 0;
        function Kt(t, i, e) {
          t.addEventListener
            ? t.addEventListener(i, e, !1)
            : t.attachEvent &&
              t.attachEvent("on".concat(i), function () {
                e(window.event);
              });
        }
        function Bt(t, i) {
          for (var e = i.slice(0, i.length - 1), n = 0; n < e.length; n++)
            e[n] = t[e[n].toLowerCase()];
          return e;
        }
        function Ut(t) {
          "string" != typeof t && (t = "");
          for (
            var i = (t = t.replace(/\s/g, "")).split(","), e = i.lastIndexOf("");
            e >= 0;

          )
            (i[e - 1] += ","), i.splice(e, 1), (e = i.lastIndexOf(""));
          return i;
        }
        for (
          var Lt = {
              backspace: 8,
              tab: 9,
              clear: 12,
              enter: 13,
              return: 13,
              esc: 27,
              escape: 27,
              space: 32,
              left: 37,
              up: 38,
              right: 39,
              down: 40,
              del: 46,
              delete: 46,
              ins: 45,
              insert: 45,
              home: 36,
              end: 35,
              pageup: 33,
              pagedown: 34,
              capslock: 20,
              num_0: 96,
              num_1: 97,
              num_2: 98,
              num_3: 99,
              num_4: 100,
              num_5: 101,
              num_6: 102,
              num_7: 103,
              num_8: 104,
              num_9: 105,
              num_multiply: 106,
              num_add: 107,
              num_enter: 108,
              num_subtract: 109,
              num_decimal: 110,
              num_divide: 111,
              "⇪": 20,
              ",": 188,
              ".": 190,
              "/": 191,
              "`": 192,
              "-": Ht ? 173 : 189,
              "=": Ht ? 61 : 187,
              ";": Ht ? 59 : 186,
              "'": 222,
              "[": 219,
              "]": 221,
              "\\": 220,
            },
            It = {
              "⇧": 16,
              shift: 16,
              "⌥": 18,
              alt: 18,
              option: 18,
              "⌃": 17,
              ctrl: 17,
              control: 17,
              "⌘": 91,
              cmd: 91,
              command: 91,
            },
            Pt = {
              16: "shiftKey",
              18: "altKey",
              17: "ctrlKey",
              91: "metaKey",
              shiftKey: 16,
              ctrlKey: 17,
              altKey: 18,
              metaKey: 91,
            },
            Rt = { 16: !1, 18: !1, 17: !1, 91: !1 },
            Vt = {},
            Nt = 1;
          Nt < 20;
          Nt++
        )
          Lt["f".concat(Nt)] = 111 + Nt;
        var Dt = [],
          Jt = "all",
          Ft = [],
          Wt = function (t) {
            return (
              Lt[t.toLowerCase()] ||
              It[t.toLowerCase()] ||
              t.toUpperCase().charCodeAt(0)
            );
          };
        function qt(t) {
          Jt = t || "all";
        }
        function Zt() {
          return Jt || "all";
        }
        var Gt = function (t) {
          var i = t.key,
            e = t.scope,
            n = t.method,
            s = t.splitKey,
            o = void 0 === s ? "+" : s;
          Ut(i).forEach(function (t) {
            var i = t.split(o),
              s = i.length,
              r = i[s - 1],
              a = "*" === r ? "*" : Wt(r);
            if (Vt[a]) {
              e || (e = Zt());
              var l = s > 1 ? Bt(It, i) : [];
              Vt[a] = Vt[a].map(function (t) {
                return (!n || t.method === n) &&
                  t.scope === e &&
                  (function (t, i) {
                    for (
                      var e = t.length >= i.length ? t : i,
                        n = t.length >= i.length ? i : t,
                        s = !0,
                        o = 0;
                      o < e.length;
                      o++
                    )
                      -1 === n.indexOf(e[o]) && (s = !1);
                    return s;
                  })(t.mods, l)
                  ? {}
                  : t;
              });
            }
          });
        };
        function Xt(t, i, e) {
          var n;
          if (i.scope === e || "all" === i.scope) {
            for (var s in ((n = i.mods.length > 0), Rt))
              Object.prototype.hasOwnProperty.call(Rt, s) &&
                ((!Rt[s] && i.mods.indexOf(+s) > -1) ||
                  (Rt[s] && -1 === i.mods.indexOf(+s))) &&
                (n = !1);
            ((0 !== i.mods.length || Rt[16] || Rt[18] || Rt[17] || Rt[91]) &&
              !n &&
              "*" !== i.shortcut) ||
              (!1 === i.method(t, i) &&
                (t.preventDefault ? t.preventDefault() : (t.returnValue = !1),
                t.stopPropagation && t.stopPropagation(),
                t.cancelBubble && (t.cancelBubble = !0)));
          }
        }
        function Qt(t) {
          var i = Vt["*"],
            e = t.keyCode || t.which || t.charCode;
          if (Yt.filter.call(this, t)) {
            if (
              ((93 !== e && 224 !== e) || (e = 91),
              -1 === Dt.indexOf(e) && 229 !== e && Dt.push(e),
              ["ctrlKey", "altKey", "shiftKey", "metaKey"].forEach(function (i) {
                var e = Pt[i];
                t[i] && -1 === Dt.indexOf(e)
                  ? Dt.push(e)
                  : !t[i] && Dt.indexOf(e) > -1
                  ? Dt.splice(Dt.indexOf(e), 1)
                  : "metaKey" === i &&
                    t[i] &&
                    3 === Dt.length &&
                    (t.ctrlKey ||
                      t.shiftKey ||
                      t.altKey ||
                      (Dt = Dt.slice(Dt.indexOf(e))));
              }),
              e in Rt)
            ) {
              for (var n in ((Rt[e] = !0), It)) It[n] === e && (Yt[n] = !0);
              if (!i) return;
            }
            for (var s in Rt)
              Object.prototype.hasOwnProperty.call(Rt, s) && (Rt[s] = t[Pt[s]]);
            t.getModifierState &&
              (!t.altKey || t.ctrlKey) &&
              t.getModifierState("AltGraph") &&
              (-1 === Dt.indexOf(17) && Dt.push(17),
              -1 === Dt.indexOf(18) && Dt.push(18),
              (Rt[17] = !0),
              (Rt[18] = !0));
            var o = Zt();
            if (i)
              for (var r = 0; r < i.length; r++)
                i[r].scope === o &&
                  (("keydown" === t.type && i[r].keydown) ||
                    ("keyup" === t.type && i[r].keyup)) &&
                  Xt(t, i[r], o);
            if (e in Vt)
              for (var a = 0; a < Vt[e].length; a++)
                if (
                  (("keydown" === t.type && Vt[e][a].keydown) ||
                    ("keyup" === t.type && Vt[e][a].keyup)) &&
                  Vt[e][a].key
                ) {
                  for (
                    var l = Vt[e][a], h = l.splitKey, c = l.key.split(h), d = [], u = 0;
                    u < c.length;
                    u++
                  )
                    d.push(Wt(c[u]));
                  d.sort().join("") === Dt.sort().join("") && Xt(t, l, o);
                }
          }
        }
        function Yt(t, i, e) {
          Dt = [];
          var n = Ut(t),
            s = [],
            o = "all",
            r = document,
            a = 0,
            l = !1,
            h = !0,
            c = "+";
          for (
            void 0 === e && "function" == typeof i && (e = i),
              "[object Object]" === Object.prototype.toString.call(i) &&
                (i.scope && (o = i.scope),
                i.element && (r = i.element),
                i.keyup && (l = i.keyup),
                void 0 !== i.keydown && (h = i.keydown),
                "string" == typeof i.splitKey && (c = i.splitKey)),
              "string" == typeof i && (o = i);
            a < n.length;
            a++
          )
            (s = []),
              (t = n[a].split(c)).length > 1 && (s = Bt(It, t)),
              (t = "*" === (t = t[t.length - 1]) ? "*" : Wt(t)) in Vt || (Vt[t] = []),
              Vt[t].push({
                keyup: l,
                keydown: h,
                scope: o,
                mods: s,
                shortcut: n[a],
                method: e,
                key: n[a],
                splitKey: c,
              });
          void 0 !== r &&
            !(function (t) {
              return Ft.indexOf(t) > -1;
            })(r) &&
            window &&
            (Ft.push(r),
            Kt(r, "keydown", function (t) {
              Qt(t);
            }),
            Kt(window, "focus", function () {
              Dt = [];
            }),
            Kt(r, "keyup", function (t) {
              Qt(t),
                (function (t) {
                  var i = t.keyCode || t.which || t.charCode,
                    e = Dt.indexOf(i);
                  if (
                    (e >= 0 && Dt.splice(e, 1),
                    t.key && "meta" === t.key.toLowerCase() && Dt.splice(0, Dt.length),
                    (93 !== i && 224 !== i) || (i = 91),
                    i in Rt)
                  )
                    for (var n in ((Rt[i] = !1), It)) It[n] === i && (Yt[n] = !1);
                })(t);
            }));
        }
        var ti = {
          setScope: qt,
          getScope: Zt,
          deleteScope: function (t, i) {
            var e, n;
            for (var s in (t || (t = Zt()), Vt))
              if (Object.prototype.hasOwnProperty.call(Vt, s))
                for (e = Vt[s], n = 0; n < e.length; )
                  e[n].scope === t ? e.splice(n, 1) : n++;
            Zt() === t && qt(i || "all");
          },
          getPressedKeyCodes: function () {
            return Dt.slice(0);
          },
          isPressed: function (t) {
            return "string" == typeof t && (t = Wt(t)), -1 !== Dt.indexOf(t);
          },
          filter: function (t) {
            var i = t.target || t.srcElement,
              e = i.tagName,
              n = !0;
            return (
              (!i.isContentEditable &&
                (("INPUT" !== e && "TEXTAREA" !== e && "SELECT" !== e) ||
                  i.readOnly)) ||
                (n = !1),
              n
            );
          },
          unbind: function (t) {
            if (t) {
              if (Array.isArray(t))
                t.forEach(function (t) {
                  t.key && Gt(t);
                });
              else if ("object" == typeof t) t.key && Gt(t);
              else if ("string" == typeof t) {
                for (
                  var i = arguments.length, e = new Array(i > 1 ? i - 1 : 0), n = 1;
                  n < i;
                  n++
                )
                  e[n - 1] = arguments[n];
                var s = e[0],
                  o = e[1];
                "function" == typeof s && ((o = s), (s = "")),
                  Gt({ key: t, scope: s, method: o, splitKey: "+" });
              }
            } else
              Object.keys(Vt).forEach(function (t) {
                return delete Vt[t];
              });
          },
        };
        for (var ii in ti)
          Object.prototype.hasOwnProperty.call(ti, ii) && (Yt[ii] = ti[ii]);
        if ("undefined" != typeof window) {
          var ei = window.hotkeys;
          (Yt.noConflict = function (t) {
            return t && window.hotkeys === Yt && (window.hotkeys = ei), Yt;
          }),
            (window.hotkeys = Yt);
        }
        var ni = function (t, i, e, n) {
          for (
            var s,
              o = arguments.length,
              r =
                o < 3
                  ? i
                  : null === n
                  ? (n = Object.getOwnPropertyDescriptor(i, e))
                  : n,
              a = t.length - 1;
            a >= 0;
            a--
          )
            (s = t[a]) && (r = (o < 3 ? s(r) : o > 3 ? s(i, e, r) : s(i, e)) || r);
          return o > 3 && r && Object.defineProperty(i, e, r), r;
        };
        let si = class extends Q {
          constructor() {
            super(...arguments),
              (this.placeholder = ""),
              (this.hideBreadcrumbs = !1),
              (this.breadcrumbHome = "Home"),
              (this.breadcrumbs = []),
              (this._inputRef = Ct());
          }
          render() {
            let t = "";
            if (!this.hideBreadcrumbs) {
              const i = [];
              for (const t of this.breadcrumbs)
                i.push(
                  T`<button tabindex="-1" @click="${() =>
                    this.selectParent(t)}" class="breadcrumb">${t}</button>`
                );
              t = T`<div class="breadcrumb-list"><button tabindex="-1" @click="${() =>
                this.selectParent()}" class="breadcrumb">${
                this.breadcrumbHome
              }</button> ${i}</div>`;
            }
            return T`${t}<div part="ninja-input-wrapper" class="search-wrapper"><input part="ninja-input" type="text" id="search" spellcheck="false" autocomplete="off" @input="${
              this._handleInput
            }" ${Tt(this._inputRef)} placeholder="${
              this.placeholder
            }" class="search"></div>`;
          }
          setSearch(t) {
            this._inputRef.value && (this._inputRef.value.value = t);
          }
          focusSearch() {
            requestAnimationFrame(() => this._inputRef.value.focus());
          }
          _handleInput(t) {
            const i = t.target;
            this.dispatchEvent(
              new CustomEvent("change", {
                detail: { search: i.value },
                bubbles: !1,
                composed: !1,
              })
            );
          }
          selectParent(t) {
            this.dispatchEvent(
              new CustomEvent("setParent", {
                detail: { parent: t },
                bubbles: !0,
                composed: !0,
              })
            );
          }
          firstUpdated() {
            this.focusSearch();
          }
          _close() {
            this.dispatchEvent(new CustomEvent("close", { bubbles: !0, composed: !0 }));
          }
        };
        (si.styles = s`:host{flex:1;position:relative}.search{padding:1.25em;flex-grow:1;flex-shrink:0;margin:0;border:none;appearance:none;font-size:1.125em;background:0 0;caret-color:var(--ninja-accent-color);color:var(--ninja-text-color);outline:0;font-family:var(--ninja-font-family)}.search::placeholder{color:var(--ninja-placeholder-color)}.breadcrumb-list{padding:1em 4em 0 1em;display:flex;flex-direction:row;align-items:stretch;justify-content:flex-start;flex:initial}.breadcrumb{background:var(--ninja-secondary-background-color);text-align:center;line-height:1.2em;border-radius:var(--ninja-key-border-radius);border:0;cursor:pointer;padding:.1em .5em;color:var(--ninja-secondary-text-color);margin-right:.5em;outline:0;font-family:var(--ninja-font-family)}.search-wrapper{display:flex;border-bottom:var(--ninja-separate-border)}`),
          ni([et()], si.prototype, "placeholder", void 0),
          ni([et({ type: Boolean })], si.prototype, "hideBreadcrumbs", void 0),
          ni([et()], si.prototype, "breadcrumbHome", void 0),
          ni([et({ type: Array })], si.prototype, "breadcrumbs", void 0),
          (si = ni([tt("ninja-header")], si));
        /**
         * @license
         * Copyright 2017 Google LLC
         * SPDX-License-Identifier: BSD-3-Clause
         */
        class oi extends ct {
          constructor(t) {
            if ((super(t), (this.it = H), t.type !== rt))
              throw Error(
                this.constructor.directiveName + "() can only be used in child bindings"
              );
          }
          render(t) {
            if (t === H || null == t) return (this.ft = void 0), (this.it = t);
            if (t === O) return t;
            if ("string" != typeof t)
              throw Error(
                this.constructor.directiveName + "() called with a non-string value"
              );
            if (t === this.it) return this.ft;
            this.it = t;
            const i = [t];
            return (
              (i.raw = i),
              (this.ft = {
                _$litType$: this.constructor.resultType,
                strings: i,
                values: [],
              })
            );
          }
        }
        (oi.directiveName = "unsafeHTML"), (oi.resultType = 1);
        const ri = ht(oi);
        /**
         * @license
         * Copyright 2021 Google LLC
         * SPDX-License-Identifier: BSD-3-Clause
         */
        /**
         * @license
         * Copyright 2021 Google LLC
         * SPDX-LIcense-Identifier: Apache-2.0
         */
        const ai = s`:host{font-family:var(--mdc-icon-font, "Material Icons");font-weight:400;font-style:normal;font-size:var(--mdc-icon-size,24px);line-height:1;letter-spacing:normal;text-transform:none;display:inline-block;white-space:nowrap;word-wrap:normal;direction:ltr;-webkit-font-smoothing:antialiased;text-rendering:optimizeLegibility;-moz-osx-font-smoothing:grayscale;font-feature-settings:"liga"}`;
        /**
         * @license
         * Copyright 2018 Google LLC
         * SPDX-License-Identifier: Apache-2.0
         */ let li = class extends Q {
          render() {
            return T`<span><slot></slot></span>`;
          }
        };
        (li.styles = [ai]),
          (li =
            /*! *****************************************************************************
        Copyright (c) Microsoft Corporation.

        Permission to use, copy, modify, and/or distribute this software for any
        purpose with or without fee is hereby granted.

        THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH
        REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY
        AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT,
        INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
        LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
        OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
        PERFORMANCE OF THIS SOFTWARE.
        ***************************************************************************** */
            (function (t, i, e, n) {
              for (
                var s,
                  o = arguments.length,
                  r =
                    o < 3
                      ? i
                      : null === n
                      ? (n = Object.getOwnPropertyDescriptor(i, e))
                      : n,
                  a = t.length - 1;
                a >= 0;
                a--
              )
                (s = t[a]) && (r = (o < 3 ? s(r) : o > 3 ? s(i, e, r) : s(i, e)) || r);
              return o > 3 && r && Object.defineProperty(i, e, r), r;
            })([tt("mwc-icon")], li));
        var hi = function (t, i, e, n) {
          for (
            var s,
              o = arguments.length,
              r =
                o < 3
                  ? i
                  : null === n
                  ? (n = Object.getOwnPropertyDescriptor(i, e))
                  : n,
              a = t.length - 1;
            a >= 0;
            a--
          )
            (s = t[a]) && (r = (o < 3 ? s(r) : o > 3 ? s(i, e, r) : s(i, e)) || r);
          return o > 3 && r && Object.defineProperty(i, e, r), r;
        };
        let ci = class extends Q {
          constructor() {
            super(),
              (this.selected = !1),
              (this.hotKeysJoinedView = !0),
              this.addEventListener("click", this.click);
          }
          ensureInView() {
            requestAnimationFrame(() => this.scrollIntoView({ block: "nearest" }));
          }
          click() {
            this.dispatchEvent(
              new CustomEvent("actionsSelected", {
                detail: this.action,
                bubbles: !0,
                composed: !0,
              })
            );
          }
          updated(t) {
            t.has("selected") && this.selected && this.ensureInView();
          }
          render() {
            let t, i;
            this.action.mdIcon
              ? (t = T`<mwc-icon part="ninja-icon" class="ninja-icon">${this.action.mdIcon}</mwc-icon>`)
              : this.action.icon && (t = ri(this.action.icon || "")),
              this.action.hotkey &&
                (i = this.hotKeysJoinedView
                  ? this.action.hotkey.split(",").map((t) => {
                      const i = t.split("+"),
                        e = T`${(function* (t, i) {
                          const e = "function" == typeof i;
                          if (void 0 !== t) {
                            let n = -1;
                            for (const s of t)
                              n > -1 && (yield e ? i(n) : i), n++, yield s;
                          }
                        })(
                          i.map((t) => T`<kbd>${t}</kbd>`),
                          "+"
                        )}`;
                      return T`<div class="ninja-hotkey ninja-hotkeys">${e}</div>`;
                    })
                  : this.action.hotkey.split(",").map((t) => {
                      const i = t
                        .split("+")
                        .map((t) => T`<kbd class="ninja-hotkey">${t}</kbd>`);
                      return T`<kbd class="ninja-hotkeys">${i}</kbd>`;
                    }));
            const e = { selected: this.selected, "ninja-action": !0 };
            return T`<div class="ninja-action" part="ninja-action ${
              this.selected ? "ninja-selected" : ""
            }" class="${Ot(e)}">${t}<div class="ninja-title">${
              this.action.title
            }</div>${i}</div>`;
          }
        };
        (ci.styles = s`:host{display:flex;width:100%}.ninja-action{padding:.75em 1em;display:flex;border-left:2px solid transparent;align-items:center;justify-content:start;outline:0;transition:color 0s ease 0s;width:100%}.ninja-action.selected{cursor:pointer;color:var(--ninja-selected-text-color);background-color:var(--ninja-selected-background);border-left:2px solid var(--ninja-accent-color);outline:0}.ninja-action.selected .ninja-icon{color:var(--ninja-selected-text-color)}.ninja-icon{font-size:var(--ninja-icon-size);max-width:var(--ninja-icon-size);max-height:var(--ninja-icon-size);margin-right:1em;color:var(--ninja-icon-color);margin-right:1em;position:relative}.ninja-title{flex-shrink:.01;margin-right:.5em;flex-grow:1;font-size:.8125em;white-space:nowrap;overflow:hidden;text-overflow:ellipsis}.ninja-hotkeys{flex-shrink:0;width:min-content;display:flex}.ninja-hotkeys kbd{font-family:inherit}.ninja-hotkey{background:var(--ninja-secondary-background-color);padding:.06em .25em;border-radius:var(--ninja-key-border-radius);text-transform:capitalize;color:var(--ninja-secondary-text-color);font-size:.75em;font-family:inherit}.ninja-hotkey+.ninja-hotkey{margin-left:.5em}.ninja-hotkeys+.ninja-hotkeys{margin-left:1em}`),
          hi([et({ type: Object })], ci.prototype, "action", void 0),
          hi([et({ type: Boolean })], ci.prototype, "selected", void 0),
          hi([et({ type: Boolean })], ci.prototype, "hotKeysJoinedView", void 0),
          (ci = hi([tt("ninja-action")], ci));
        const di = T`<div class="modal-footer" slot="footer"><span class="help"><svg version="1.0" class="ninja-examplekey" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1280 1280"><path d="M1013 376c0 73.4-.4 113.3-1.1 120.2a159.9 159.9 0 0 1-90.2 127.3c-20 9.6-36.7 14-59.2 15.5-7.1.5-121.9.9-255 1h-242l95.5-95.5 95.5-95.5-38.3-38.2-38.2-38.3-160 160c-88 88-160 160.4-160 161 0 .6 72 73 160 161l160 160 38.2-38.3 38.3-38.2-95.5-95.5-95.5-95.5h251.1c252.9 0 259.8-.1 281.4-3.6 72.1-11.8 136.9-54.1 178.5-116.4 8.6-12.9 22.6-40.5 28-55.4 4.4-12 10.7-36.1 13.1-50.6 1.6-9.6 1.8-21 2.1-132.8l.4-122.2H1013v110z"/></svg> to select </span><span class="help"><svg xmlns="http://www.w3.org/2000/svg" class="ninja-examplekey" viewBox="0 0 24 24"><path d="M0 0h24v24H0V0z" fill="none"/><path d="M20 12l-1.41-1.41L13 16.17V4h-2v12.17l-5.58-5.59L4 12l8 8 8-8z"/></svg> <svg xmlns="http://www.w3.org/2000/svg" class="ninja-examplekey" viewBox="0 0 24 24"><path d="M0 0h24v24H0V0z" fill="none"/><path d="M4 12l1.41 1.41L11 7.83V20h2V7.83l5.58 5.59L20 12l-8-8-8 8z"/></svg> to navigate </span><span class="help"><span class="ninja-examplekey esc">esc</span> to close </span><span class="help"><svg xmlns="http://www.w3.org/2000/svg" class="ninja-examplekey backspace" viewBox="0 0 20 20" fill="currentColor"><path fill-rule="evenodd" d="M6.707 4.879A3 3 0 018.828 4H15a3 3 0 013 3v6a3 3 0 01-3 3H8.828a3 3 0 01-2.12-.879l-4.415-4.414a1 1 0 010-1.414l4.414-4.414zm4 2.414a1 1 0 00-1.414 1.414L10.586 10l-1.293 1.293a1 1 0 101.414 1.414L12 11.414l1.293 1.293a1 1 0 001.414-1.414L13.414 10l1.293-1.293a1 1 0 00-1.414-1.414L12 8.586l-1.293-1.293z" clip-rule="evenodd"/></svg> move to parent</span></div>`,
          ui = s`:host{--ninja-width:640px;--ninja-backdrop-filter:none;--ninja-overflow-background:rgba(255, 255, 255, 0.5);--ninja-text-color:rgb(60, 65, 73);--ninja-font-size:16px;--ninja-top:20%;--ninja-key-border-radius:0.25em;--ninja-accent-color:rgb(110, 94, 210);--ninja-secondary-background-color:rgb(239, 241, 244);--ninja-secondary-text-color:rgb(107, 111, 118);--ninja-selected-background:rgb(248, 249, 251);--ninja-icon-color:var(--ninja-secondary-text-color);--ninja-icon-size:1.2em;--ninja-separate-border:1px solid var(--ninja-secondary-background-color);--ninja-modal-background:#fff;--ninja-modal-shadow:rgb(0 0 0 / 50%) 0px 16px 70px;--ninja-actions-height:300px;--ninja-group-text-color:rgb(144, 149, 157);--ninja-footer-background:rgba(242, 242, 242, 0.4);--ninja-placeholder-color:#8e8e8e;font-size:var(--ninja-font-size);--ninja-z-index:1}:host(.dark){--ninja-backdrop-filter:none;--ninja-overflow-background:rgba(0, 0, 0, 0.7);--ninja-text-color:#7d7d7d;--ninja-modal-background:rgba(17, 17, 17, 0.85);--ninja-accent-color:rgb(110, 94, 210);--ninja-secondary-background-color:rgba(51, 51, 51, 0.44);--ninja-secondary-text-color:#888;--ninja-selected-text-color:#eaeaea;--ninja-selected-background:rgba(51, 51, 51, 0.44);--ninja-icon-color:var(--ninja-secondary-text-color);--ninja-separate-border:1px solid var(--ninja-secondary-background-color);--ninja-modal-shadow:0 16px 70px rgba(0, 0, 0, 0.2);--ninja-group-text-color:rgb(144, 149, 157);--ninja-footer-background:rgba(30, 30, 30, 85%)}.modal{display:none;position:fixed;z-index:var(--ninja-z-index);left:0;top:0;width:100%;height:100%;overflow:auto;background:var(--ninja-overflow-background);-webkit-font-smoothing:antialiased;-moz-osx-font-smoothing:grayscale;-webkit-backdrop-filter:var(--ninja-backdrop-filter);backdrop-filter:var(--ninja-backdrop-filter);text-align:left;color:var(--ninja-text-color);font-family:var(--ninja-font-family)}.modal.visible{display:block}.modal-content{position:relative;top:var(--ninja-top);margin:auto;padding:0;display:flex;flex-direction:column;flex-shrink:1;-webkit-box-flex:1;flex-grow:1;min-width:0;will-change:transform;background:var(--ninja-modal-background);border-radius:.5em;box-shadow:var(--ninja-modal-shadow);max-width:var(--ninja-width);overflow:hidden}.bump{animation:zoom-in-zoom-out .2s ease}@keyframes zoom-in-zoom-out{0%{transform:scale(.99)}50%{transform:scale(1.01,1.01)}100%{transform:scale(1,1)}}.ninja-github{color:var(--ninja-keys-text-color);font-weight:400;text-decoration:none}.actions-list{max-height:var(--ninja-actions-height);overflow:auto;scroll-behavior:smooth;position:relative;margin:0;padding:.5em 0;list-style:none;scroll-behavior:smooth}.group-header{height:1.375em;line-height:1.375em;padding-left:1.25em;padding-top:.5em;text-overflow:ellipsis;white-space:nowrap;overflow:hidden;font-size:.75em;line-height:1em;color:var(--ninja-group-text-color);margin:1px 0}.modal-footer{background:var(--ninja-footer-background);padding:.5em 1em;display:flex;border-top:var(--ninja-separate-border);color:var(--ninja-secondary-text-color)}.modal-footer .help{display:flex;margin-right:1em;align-items:center;font-size:.75em}.ninja-examplekey{background:var(--ninja-secondary-background-color);padding:.06em .25em;border-radius:var(--ninja-key-border-radius);color:var(--ninja-secondary-text-color);width:1em;height:1em;margin-right:.5em;font-size:1.25em;fill:currentColor}.ninja-examplekey.esc{width:auto;height:auto;font-size:1.1em}.ninja-examplekey.backspace{opacity:.7}`;
        var vi = function (t, i, e, n) {
          for (
            var s,
              o = arguments.length,
              r =
                o < 3
                  ? i
                  : null === n
                  ? (n = Object.getOwnPropertyDescriptor(i, e))
                  : n,
              a = t.length - 1;
            a >= 0;
            a--
          )
            (s = t[a]) && (r = (o < 3 ? s(r) : o > 3 ? s(i, e, r) : s(i, e)) || r);
          return o > 3 && r && Object.defineProperty(i, e, r), r;
        };
        let fi = class extends Q {
          constructor() {
            super(...arguments),
              (this.placeholder = "Type a command or search..."),
              (this.disableHotkeys = !1),
              (this.hideBreadcrumbs = !1),
              (this.openHotkey = "cmd+k,ctrl+k"),
              (this.navigationUpHotkey = "up,shift+tab"),
              (this.navigationDownHotkey = "down,tab"),
              (this.closeHotkey = "esc"),
              (this.goBackHotkey = "backspace"),
              (this.selectHotkey = "enter"),
              (this.hotKeysJoinedView = !1),
              (this.noAutoLoadMdIcons = !1),
              (this.data = []),
              (this.visible = !1),
              (this._bump = !0),
              (this._actionMatches = []),
              (this._search = ""),
              (this._flatData = []),
              (this._headerRef = Ct());
          }
          open(t = {}) {
            (this._bump = !0),
              (this.visible = !0),
              this._headerRef.value.focusSearch(),
              this._actionMatches.length > 0 &&
                (this._selected = this._actionMatches[0]),
              this.setParent(t.parent);
          }
          close() {
            (this._bump = !1), (this.visible = !1);
          }
          setParent(t) {
            (this._currentRoot = t || void 0),
              (this._selected = void 0),
              (this._search = ""),
              this._headerRef.value.setSearch("");
          }
          get breadcrumbs() {
            var t;
            const i = [];
            let e = null === (t = this._selected) || void 0 === t ? void 0 : t.parent;
            if (e)
              for (i.push(e); e; ) {
                const t = this._flatData.find((t) => t.id === e);
                (null == t ? void 0 : t.parent) && i.push(t.parent),
                  (e = t ? t.parent : void 0);
              }
            return i.reverse();
          }
          connectedCallback() {
            super.connectedCallback(),
              this.noAutoLoadMdIcons ||
                document.fonts.load("24px Material Icons", "apps").then(() => {}),
              this._registerInternalHotkeys();
          }
          disconnectedCallback() {
            super.disconnectedCallback(), this._unregisterInternalHotkeys();
          }
          _flattern(t, i) {
            let e = [];
            return (
              t || (t = []),
              t
                .map((t) => {
                  const n = t.children && t.children.some((t) => "string" == typeof t),
                    s = { ...t, parent: t.parent || i };
                  return (
                    n ||
                      (s.children &&
                        s.children.length &&
                        ((i = t.id), (e = [...e, ...s.children])),
                      (s.children = s.children ? s.children.map((t) => t.id) : [])),
                    s
                  );
                })
                .concat(e.length ? this._flattern(e, i) : e)
            );
          }
          update(t) {
            t.has("data") &&
              !this.disableHotkeys &&
              ((this._flatData = this._flattern(this.data)),
              this._flatData
                .filter((t) => !!t.hotkey)
                .forEach((t) => {
                  Yt(t.hotkey, (i) => {
                    i.preventDefault(), t.handler && t.handler(t);
                  });
                })),
              super.update(t);
          }
          _registerInternalHotkeys() {
            this.openHotkey &&
              Yt(this.openHotkey, (t) => {
                t.preventDefault(), this.visible ? this.close() : this.open();
              }),
              this.selectHotkey &&
                Yt(this.selectHotkey, (t) => {
                  this.visible &&
                    (t.preventDefault(),
                    this._actionSelected(this._actionMatches[this._selectedIndex]));
                }),
              this.goBackHotkey &&
                Yt(this.goBackHotkey, (t) => {
                  this.visible &&
                    (this._search || (t.preventDefault(), this._goBack()));
                }),
              this.navigationDownHotkey &&
                Yt(this.navigationDownHotkey, (t) => {
                  this.visible &&
                    (t.preventDefault(),
                    this._selectedIndex >= this._actionMatches.length - 1
                      ? (this._selected = this._actionMatches[0])
                      : (this._selected =
                          this._actionMatches[this._selectedIndex + 1]));
                }),
              this.navigationUpHotkey &&
                Yt(this.navigationUpHotkey, (t) => {
                  this.visible &&
                    (t.preventDefault(),
                    0 === this._selectedIndex
                      ? (this._selected =
                          this._actionMatches[this._actionMatches.length - 1])
                      : (this._selected =
                          this._actionMatches[this._selectedIndex - 1]));
                }),
              this.closeHotkey &&
                Yt(this.closeHotkey, () => {
                  this.visible && this.close();
                });
          }
          _unregisterInternalHotkeys() {
            this.openHotkey && Yt.unbind(this.openHotkey),
              this.selectHotkey && Yt.unbind(this.selectHotkey),
              this.goBackHotkey && Yt.unbind(this.goBackHotkey),
              this.navigationDownHotkey && Yt.unbind(this.navigationDownHotkey),
              this.navigationUpHotkey && Yt.unbind(this.navigationUpHotkey),
              this.closeHotkey && Yt.unbind(this.closeHotkey);
          }
          _actionFocused(t, i) {
            (this._selected = t), i.target.ensureInView();
          }
          _onTransitionEnd() {
            this._bump = !1;
          }
          _goBack() {
            const t =
              this.breadcrumbs.length > 1
                ? this.breadcrumbs[this.breadcrumbs.length - 2]
                : void 0;
            this.setParent(t);
          }
          render() {
            const t = { bump: this._bump, "modal-content": !0 },
              i = { visible: this.visible, modal: !0 },
              e = this._flatData
                .filter((t) => {
                  var i;
                  const e = new RegExp(this._search, "gi"),
                    n =
                      t.title.match(e) ||
                      (null === (i = t.keywords) || void 0 === i ? void 0 : i.match(e));
                  return (
                    ((!this._currentRoot && this._search) ||
                      t.parent === this._currentRoot) &&
                    n
                  );
                })
                .reduce(
                  (t, i) => t.set(i.section, [...(t.get(i.section) || []), i]),
                  new Map()
                );
            (this._actionMatches = [...e.values()].flat()),
              this._actionMatches.length > 0 &&
                -1 === this._selectedIndex &&
                (this._selected = this._actionMatches[0]),
              0 === this._actionMatches.length && (this._selected = void 0);
            const n = (t) =>
                T`${wt(
                  t,
                  (t) => t.id,
                  (t) => {
                    var i;
                    return T`<ninja-action exportparts="ninja-action,ninja-selected,ninja-icon" .selected="${jt(
                      t.id ===
                        (null === (i = this._selected) || void 0 === i ? void 0 : i.id)
                    )}" .hotKeysJoinedView="${this.hotKeysJoinedView}" @mouseover="${(
                      i
                    ) => this._actionFocused(t, i)}" @actionsSelected="${(t) =>
                      this._actionSelected(t.detail)}" .action="${t}"></ninja-action>`;
                  }
                )}`,
              s = [];
            return (
              e.forEach((t, i) => {
                const e = i ? T`<div class="group-header">${i}</div>` : void 0;
                s.push(T`${e}${n(t)}`);
              }),
              T`<div @click="${this._overlayClick}" class="${Ot(i)}"><div class="${Ot(
                t
              )}" @animationend="${
                this._onTransitionEnd
              }"><ninja-header exportparts="ninja-input,ninja-input-wrapper" ${Tt(
                this._headerRef
              )} .placeholder="${this.placeholder}" .hideBreadcrumbs="${
                this.hideBreadcrumbs
              }" .breadcrumbs="${this.breadcrumbs}" @change="${
                this._handleInput
              }" @setParent="${(t) => this.setParent(t.detail.parent)}" @close="${
                this.close
              }"></ninja-header><div class="modal-body"><div class="actions-list" part="actions-list">${s}</div></div><slot name="footer">${di}</slot></div></div>`
            );
          }
          get _selectedIndex() {
            return this._selected ? this._actionMatches.indexOf(this._selected) : -1;
          }
          _actionSelected(t) {
            var i;
            if (
              (this.dispatchEvent(
                new CustomEvent("selected", {
                  detail: { search: this._search, action: t },
                  bubbles: !0,
                  composed: !0,
                })
              ),
              t)
            ) {
              if (
                (t.children &&
                  (null === (i = t.children) || void 0 === i ? void 0 : i.length) > 0 &&
                  ((this._currentRoot = t.id), (this._search = "")),
                this._headerRef.value.setSearch(""),
                this._headerRef.value.focusSearch(),
                t.handler)
              ) {
                const i = t.handler(t);
                (null == i ? void 0 : i.keepOpen) || this.close();
              }
              this._bump = !0;
            }
          }
          async _handleInput(t) {
            (this._search = t.detail.search),
              await this.updateComplete,
              this.dispatchEvent(
                new CustomEvent("change", {
                  detail: { search: this._search, actions: this._actionMatches },
                  bubbles: !0,
                  composed: !0,
                })
              );
          }
          _overlayClick(t) {
            var i;
            (null === (i = t.target) || void 0 === i
              ? void 0
              : i.classList.contains("modal")) && this.close();
          }
        };
        (fi.styles = [ui]),
          vi([et({ type: String })], fi.prototype, "placeholder", void 0),
          vi([et({ type: Boolean })], fi.prototype, "disableHotkeys", void 0),
          vi([et({ type: Boolean })], fi.prototype, "hideBreadcrumbs", void 0),
          vi([et()], fi.prototype, "openHotkey", void 0),
          vi([et()], fi.prototype, "navigationUpHotkey", void 0),
          vi([et()], fi.prototype, "navigationDownHotkey", void 0),
          vi([et()], fi.prototype, "closeHotkey", void 0),
          vi([et()], fi.prototype, "goBackHotkey", void 0),
          vi([et()], fi.prototype, "selectHotkey", void 0),
          vi([et({ type: Boolean })], fi.prototype, "hotKeysJoinedView", void 0),
          vi([et({ type: Boolean })], fi.prototype, "noAutoLoadMdIcons", void 0),
          vi([et({ type: Array, hasChanged: () => !0 })], fi.prototype, "data", void 0),
          vi([nt()], fi.prototype, "visible", void 0),
          vi([nt()], fi.prototype, "_bump", void 0),
          vi([nt()], fi.prototype, "_actionMatches", void 0),
          vi([nt()], fi.prototype, "_search", void 0),
          vi([nt()], fi.prototype, "_currentRoot", void 0),
          vi([nt()], fi.prototype, "_flatData", void 0),
          vi([nt()], fi.prototype, "breadcrumbs", null),
          vi([nt()], fi.prototype, "_selected", void 0),
          (fi = vi([tt("ninja-keys")], fi));