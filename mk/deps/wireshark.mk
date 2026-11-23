wireshark_VERSION := 5.0.0rc2
wireshark_URL     := https://www.wireshark.org/download/src/all-versions/wireshark-$(wireshark_VERSION).tar.xz
wireshark_SHA512  := 5e430827dc05cd1c8f28a1f1baba7ee31ee29c2a1633720f320e8bc576e298dafc607f4c4108b48a6109929fb0333837c70ed089a55de6eb0d596fa5d5af79ab
wireshark_BUILD   := cmake
wireshark_DEPS    := c-ares gcrypt glib libxml2 nghttp2
# only libwireshark (epan) is needed: no tools, no C plugins (not loadable in
# wasm; Lua plugins are separate), and static libraries
# (newer emscripten supports shared libraries, which would otherwise be the default)
wireshark_CONF    := \
	$(foreach t,wireshark tshark rawshark dumpcap text2pcap mergecap reordercap editcap \
		capinfos captype randpkt dftest dcerpcidl2wrs androiddump sshdump ciscodump \
		dpauxmon randpktdump wifidump etwdump sdjournal udpdump sharkd mmdbresolve,-DBUILD_$(t)=OFF) \
	-DFETCH_lua=ON \
	-DENABLE_CAP=OFF \
	-DBUILD_SHARED_LIBS=OFF \
	-DENABLE_PLUGINS=OFF
