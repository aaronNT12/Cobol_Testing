identification division.
program-id. deleting.

environment division.
configuration section.

input-output section.
file-control.
	select optional indexed-file
	assign to "indexed-file.dat"
	status is indexing-status
	organization is indexed
	access mode is dynamic
	record key is keyfield
	alternate record key is altkey with duplicates
	.
...

procedure division.

move "abcdef" to keyfield

*> Delete a record by index
delete indexed-file record
	invalid key
		display "No delete of " keyfield end-display
	not invalid key
		display "Record " keyfield " removed" end-display
end-delete

perform check-delete-status
...