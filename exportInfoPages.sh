for i in `ls /sbin`; do info $i | > "$i".md; done

for i in `ls /bin`; do info $i | > "$i".md; done

for i in `ls /usr/bin`; do info $i | > "$i".md; done

for i in `ls /usr/sbin`; do info $i | > "$i".md; done

for i in `ls /usr/local/sbin`; do info $i | > "$i".md; done

for i in `ls /usr/local/bin`; do info $i | > "$i".md; done
