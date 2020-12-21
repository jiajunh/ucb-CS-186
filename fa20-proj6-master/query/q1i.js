// Task 1i

db.keywords.aggregate([
    // TODO: Write your query here
	{
		$match: {
	    	$or: [
	    		{keywords: {$elemMatch: {name: "time travel"}}},
	    		{keywords: {$elemMatch: {name: "presidential election"}}}
	    	]
	    }
    },

	{$sort: {"movieId": 1}},

    {$project: {
    	_id: 0,
    	movieId: 1
    }}
]);