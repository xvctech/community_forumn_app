<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Post;
use App\Models\Comment;


class CommentController extends Controller
{
    //get all comments of a post
    public function index($id){
        $post = post::find($id);

        if(!$post)
        {
            return response([
                'mesage'=> 'post not found.'
            ], 403);
        }
        return response([
            'comments'=> $post->comments()->with('user:id,name,image')->get()
        ], 200);
    }
    //create a comment
    public function store(Request $request, $id){

        $post = post::find($id);

        if(!$post)
        {
            return response([
                'mesage'=> 'post not found.'
            ], 403);
        }

        //validate fields
        $attrs = $request -> validate([
            'comment' => 'required|string'
        ]);

        comment::create([
            'comment' => $attrs['comment'],
            'post_id' =>$id,
            'user_id' => auth() ->user()->id
        ]);

        return response([
            'message' => 'comment created.'
        ], 200);
    }
    //update a comment
    public function update(Request $request, $id){
        $comment = Comment::find($id);

        if(!$comment){
            return response ([
                'message'=>'comment not found.'
            ],403);
        }
        if($comment->user_id != auth()->user()->id){
            return response([
                'message' => 'permission denied'
            ],403);
        }
        //validation fields
        $attrs = $request->validate([
            'comment'=> 'required|string'
        ]);
        $comment->update([
            'comment'=>$attrs['comment']
        ]);
        return response([
            'message' => 'comment updated'
        ],200);
    }

    public function destroy($id){
        $comment = Comment::find($id);

        if(!$comment){
            return response ([
                'message'=>'comment not found.'
            ],403);
        }
        if($comment->user_id != auth()->user()->id){
            return response([
                'message' => 'permission denied'
            ],403);
        }
    $comment -> delete();
    return response([
        'message' => 'comment deleted'
    ],200);

    }
}
