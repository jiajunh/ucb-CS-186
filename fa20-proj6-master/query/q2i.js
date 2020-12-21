// Task 2i

db.movies_metadata.aggregate([
    // TODO: Write your query here
    {
    	$project: {
    		_id: 0,
    		title: "$title",
    		vote_count: "$vote_count",
    		score: {
    			$round: [{$add: [{$divide: [{$multiply: ["$vote_count", "$vote_average"]}, {$add: ["$vote_count", 1838]}]}, 
    				   			{$divide: [{$multiply: [1838, 7]}, {$add: ["$vote_count", 1838]}]}]} , 2] 
    		}
    	}
    },

    {
    	$sort: {
    		score: -1,
    		vote_count: -1,
    		title: 1
    	}
    },

    {
    	$limit: 20
    }
]);