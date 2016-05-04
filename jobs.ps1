[System.Collections.ArrayList]$jobs = @()
[System.Collections.ArrayList]$donejobs = @()

$jobs += (start-job -name "fast job" -ScriptBlock {

	for ($i=1; $i -lt 5; $i++) {
		write-host $i
		sleep 5
	}

})

write-host $jobs.count "jobs queued"

$jobs += (start-job -name "Copy Job" -ScriptBlock {

	for ($i=1; $i -lt 20; $i++) {
		write-host $i
		sleep 5
	}

})

write-host $jobs.count "jobs queued"

# Keep looping until all jobs are in a completed state
while ($donejobs.count -lt $jobs.count) {
	foreach ($job in $jobs) {
		if ($job.state -eq "Completed") {
			$donejobs.add($job)
		}
		
		write-host *************************************
		write-host $donejobs.count "jobs are completed"
		write-host ($jobs.count - $donejobs.count) "are still running"
		write-host *************************************
		sleep 3

	}
}